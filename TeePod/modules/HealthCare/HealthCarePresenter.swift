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
import HealthKit

final class HealthCarePresenter: ObservableObject {
  private let router = HealthCareRouter()
  private let interactor = HealthCareInteractor()
  private let healthStore = HKHealthStore()
  
  var calendar = Calendar.current  // カレンダーを取得
  
  
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
}

extension HealthCarePresenter {
  func onTapButton() {
    if(self.flag){
      self.comment = "Get Data"
      self.flag = false
    }else{
      if HKHealthStore.isHealthDataAvailable() {
        self.comment = "HealthKit Available"
        self.interactor.authorizeHealthStore(Store: self.healthStore)
          .subscribe(Subscribers.Sink(
            receiveCompletion: { completion in
              switch completion {
              case .finished:
                self.interactor.getStepCount(Store: self.healthStore)
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
        self.comment = "Unavailable"}
      self.flag = true
    }
  }
}

extension HealthCarePresenter {}
