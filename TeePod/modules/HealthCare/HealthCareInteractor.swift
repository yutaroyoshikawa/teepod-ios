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
    func getStepCount(Store: HKHealthStore) -> Double{
        let end = Date()
        let start:Date =  Calendar.current.date(byAdding: .hour, value: -5, to: end)!
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        var step = 0.0  // 結果を格納するための変数
        
        // クエリを作る
        let type = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options:.cumulativeSum){
            query, result, error in
            let query_result = result?.sumQuantity() as Any
            step = (query_result as AnyObject).doubleValue(for: HKUnit.count())
            print(step)
        }
        Store.execute(query)
        return step
    }
}
