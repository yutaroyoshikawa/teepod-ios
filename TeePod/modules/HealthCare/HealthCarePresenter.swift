//
//  HealthCareHealthCarePresenter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 26/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class HealthCarePresenter: ObservableObject {
  private let router = HealthCareRouter()
  private let interactor = HealthCareInteractor()
  
  let objectWillChange = ObservableObjectPublisher()
  
  @Published var flag = false {
    willSet {
      self.objectWillChange.send()
    }
  }
  
  @Published var comment = "" {
    willSet {
      self.objectWillChange.send()
    }
  }
  
  func updateComment(content: String) {
    DispatchQueue.main.async {
      self.comment = content
    }
  }
  
  func updateFlag(flag: Bool) {
    DispatchQueue.main.async {
      self.flag = flag
    }
  }
}

extension HealthCarePresenter {
  func onTapButton() {
    if(self.flag){
      self.updateComment(content: "Get Data")
      self.updateFlag(flag: false)
    }else{
      let isHealthDataAvailable = self.interactor.getIsHealthDataAvailable()
      if (isHealthDataAvailable) {
        self.updateComment(content: "HealthKit Available")
        self.interactor.authorizeHealthStore()
          .subscribe(Subscribers.Sink(
            receiveCompletion: { completion in
              switch completion {
              case .finished:
                self.interactor.getStepCount()
                  .subscribe(Subscribers.Sink(
                    receiveCompletion: { _ in },
                    receiveValue: ({
                      print("value: \($0)")
                      self.updateComment(content: "walk \($0) step")
                    })
                  ))
              case .failure(let error):
                print("error \(error)")
              }
          },
            receiveValue: { _ in}
          ))
      }else{
        self.updateComment(content: "Unavailable")
      }
      self.updateFlag(flag: true)
    }
  }
}

extension HealthCarePresenter {}
