//
//  HomePresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let interactor = HomeInteractor()
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var isLaunchLight = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var stepCount = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    func updateStepCount(stepCount: Int) {
        DispatchQueue.main.async {
            self.stepCount = stepCount
        }
    }
}

extension HomePresenter {
    func requestGetStepCount() {
        let isHealthDataAvailable = interactor.getIsHealthDataAvailable()
        if isHealthDataAvailable {
            interactor.authorizeHealthStore()
                .subscribe(Subscribers.Sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            self.interactor.getStepCount()
                                .subscribe(Subscribers.Sink(
                                    receiveCompletion: { _ in },
                                    receiveValue: ({ result in
                                        self.updateStepCount(stepCount: Int(result))
                                    })
                                ))
                        case let .failure(error):
                            print("error \(error)")
                        }
                    },
                    receiveValue: { _ in }
                ))
        }
    }
    
    func getMode() -> String {
        let current_step = stepCount
        let paripi_time: Date? = getParipiTime()
        var mode: String
        
        let judge_reset = calcResetStep(current_step: current_step)
        if judge_reset == 60 {
            mode = "nomal"
        } else {
            mode = judgeMode(paripi_time: paripi_time!)
        }
        return mode
    }
    
    func getModeColor() -> [UIColor] {
        let mode_colors: [UIColor] = judgeModeColor(mode: getMode())
        return mode_colors
    }
    
    func getResetStep() -> Int {
        let result = calcResetStep(current_step: stepCount)
        return result
    }
    
    func calcResetStep(current_step: Int) -> Int {
        let border_step = 60
        let step = border_step - current_step
        if step <= 0 {
            setParipiTime()
            return 60
        } else {
            return step
        }
    }
}

extension HomePresenter {
    func arLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeArView()) {
            content()
        }
    }
    
    func checkLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeCheckView()) {
            content()
        }
    }
    
    func onTapPower() {
        isLaunchLight = !isLaunchLight
    }
    
    func onTapReloadStepCount() {
        requestGetStepCount()
    }
}
