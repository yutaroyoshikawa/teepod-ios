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
    
    @Published var resetStep = 0 {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    func updateStepCount(stepCount: Int) {
        let resetStep = calcResetStep(current_step: stepCount)
        DispatchQueue.main.async {
            self.stepCount = stepCount
            self.resetStep = resetStep
        }
    }
    
    func updateIsLaunchLight() {
        let isLaunch = interactor.getIsLaunch()
        DispatchQueue.main.async {
            self.isLaunchLight = isLaunch
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
                                    receiveValue: { result in
                                        self.updateStepCount(stepCount: Int(result))
                                    }
                                ))
                        case let .failure(error):
                            print("error \(error)")
                        }
                    },
                    receiveValue: { _ in }
                ))
        }
    }
    
    func getMode(step: Int) -> Mode {
        let current_step = step
        let paripi_time = interactor.requestGetParipiTime()
        let judge_reset = calcResetStep(current_step: current_step)
        let mode = interactor.requestGetMode(paripiTime: paripi_time!)
        
        _ = interactor.requestPostModeColor(mode: mode)
        
        if judge_reset == 60 {
            return Mode.normal
        }
        
        return mode
    }
    
    func getModeColor(step: Int) -> [UIColor] {
        let mode_colors: [UIColor] = interactor.requestGetModeColor(mode: getMode(step: step))
        return mode_colors
    }
    
    func calcResetStep(current_step: Int) -> Int {
        let border_step = 60
        let step = border_step - current_step
        if step <= 0 {
            interactor.requestSetParipiTime()
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
        interactor.requestPostIsLaunch(isLaunch: !isLaunchLight)
            .subscribe(Subscribers.Sink<String, Error>(
                receiveCompletion: { _ in },
                receiveValue: { _ in
                    let updatedIsLaunch = !self.isLaunchLight
                    if updatedIsLaunch {
                        self.interactor.requestSetParipiTime()
                    }
                    self.interactor.setIsLaunch(isLaunch: updatedIsLaunch)
                    self.updateIsLaunchLight()
                }
            ))
    }
    
    func onTapReloadStepCount() {
        requestGetStepCount()
    }
}
