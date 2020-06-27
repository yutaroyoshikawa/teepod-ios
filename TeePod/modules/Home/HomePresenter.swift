//
//  HomePresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class HomePresenter: ObservableObject {
  private let router = HomeRouter()
  private let interactor = HomeInteractor()
  
  let objectWillChange = ObservableObjectPublisher()
  
  @Published var isLaunchLight = false {
    willSet {
      self.objectWillChange.send()
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
    let isHealthDataAvailable = self.interactor.getIsHealthDataAvailable()
    if (isHealthDataAvailable) {
      self.interactor.authorizeHealthStore()
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
            case .failure(let error):
              print("error \(error)")
            }
        },
          receiveValue: { _ in}
        ))
    }
  }
}

extension HomePresenter {
    func arLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
      return NavigationLink(destination: self.router.makeArView()) {
          content()
      }
  }
  
  func checkLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
      return NavigationLink(destination: self.router.makeCheckView()) {
          content()
      }
  }
  
  func onTapPower() {
    self.isLaunchLight = !self.isLaunchLight
  }
  
  func onTapReloadStepCount() {
    self.requestGetStepCount()
  }
}
