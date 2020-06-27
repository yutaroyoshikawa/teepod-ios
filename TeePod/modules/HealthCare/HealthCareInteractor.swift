//
//  HealthCareHealthCareInteractor.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 26/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import Combine
import HealthKit

final class HealthCareInteractor {
  private let healthStore = HKHealthStore()
  
  func getIsHealthDataAvailable() -> Bool {
    return HKHealthStore.isHealthDataAvailable()
  }
  
  func authorizeHealthStore() -> Future<Bool, Error> {
    let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    return Future { promise in
      self.healthStore.requestAuthorization(toShare: nil, read: allTypes) {
        (success, error) in
        if (error != nil) {
          promise(.failure(error!))
        }
        promise(.success(success))
      }
    }
  }
  
  func getStepCount() -> Future<Double, Error> {
    return Future { promise in
      let end = Date()
      let start:Date =  Calendar.current.date(byAdding: .hour, value: -5, to: end)!
      
      let predicate = HKQuery.predicateForSamples(withStart: start, end: end)

      let type = HKObjectType.quantityType(forIdentifier: .stepCount)!
      let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options:.cumulativeSum){
        query, result, error in
        if (error != nil) {
          promise(.failure(error!))
        }
        let query_result = result?.sumQuantity()
        let step = (query_result as AnyObject).doubleValue(for: HKUnit.count())
        promise(.success(step))
      }
      self.healthStore.execute(query)
    }
  }
}
