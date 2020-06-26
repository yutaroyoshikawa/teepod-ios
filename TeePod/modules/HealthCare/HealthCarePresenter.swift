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
    private let healthStore = HKHealthStore()  // HealthKitのデータを格納するHealthStoreを定義
    // アクセス許可が欲しいデータタイプを指定
    private let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])  //今回は歩数のみ
    
    // 以下を追加
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
}

extension HealthCarePresenter {
    func onTapButton() {
        if(self.flag){
            self.comment = "Get Data"
            self.flag = false
        }else{
            // ボタンがタップされた時
            // もしHealthKitが利用可能なら
            if HKHealthStore.isHealthDataAvailable() {
                self.comment = "HealthKit Available"
                self.healthStore.requestAuthorization(toShare: nil, read: self.allTypes) { (success, error) in
                    let step = self.interactor.getStepCount(Store: self.healthStore)
                    print(step)
                }
                
            }else{
                self.comment = "Unavailable"}
            self.flag = true
        }
    }
}

extension HealthCarePresenter {}
