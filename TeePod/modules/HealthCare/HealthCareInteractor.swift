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
  func authorizeHealthStore(Store: HKHealthStore) -> Future<Bool, Error> {
    let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
    return Future { promise in
      Store.requestAuthorization(toShare: nil, read: allTypes) {
        (success, error) in
        if (error != nil) {
          promise(.failure(error!))
        }
        promise(.success(success))
      }
    }
  }
  
  func getStepCount(Store: HKHealthStore) -> Future<Double, Error> {
    return Future { promise in
      let end = Date()
      let start:Date =  Calendar.current.date(byAdding: .hour, value: -5, to: end)!
      
      let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
      var step = 0.0

      let type = HKObjectType.quantityType(forIdentifier: .stepCount)!
      let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options:.cumulativeSum){
        query, result, error in
        if (error != nil) {
          promise(.failure(error!))
        }
        let query_result = result?.sumQuantity()
        step = (query_result as AnyObject).doubleValue(for: HKUnit.count())
        promise(.success(step))
      }
      Store.execute(query)
    }
  }
}
