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
                                    receiveValue: ({
                                        result in
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
}

extension HomePresenter {
    func arLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: router.makeArView()) {
            content()
        }
    }
    
    func checkLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: router.makeCheckView()) {
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
