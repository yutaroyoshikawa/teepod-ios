//
//  HomeInteractor.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Combine
import Foundation
import HealthKit
import Moya

final class HomeInteractor {
    private let healthStore = HKHealthStore()
    private let api = MoyaProvider<TeePodAPI>()
    
    func getIsHealthDataAvailable() -> Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func authorizeHealthStore() -> Future<Bool, Error> {
        let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        return Future { promise in
            self.healthStore.requestAuthorization(toShare: nil, read: allTypes) { success, error in
                if error != nil {
                    promise(.failure(error!))
                }
                promise(.success(success))
            }
        }
    }
    
    func getStepCount() -> Future<Double, Error> {
        Future { promise in
            let now = Date()
            let paripi_time: Date = getParipiTime()
            var start: Date = Date()
            var end: Date = Date()
            
            if now.compare(paripi_time) == .orderedAscending {
                start = Calendar.current.date(byAdding: .minute, value: -60, to: paripi_time)!
                end = now
            } else {
                start = paripi_time
                end = now
            }
            
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
            let type = HKObjectType.quantityType(forIdentifier: .stepCount)!
            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                if error != nil {
                    promise(.failure(error!))
                }
                let query_result = result?.sumQuantity()
                let step = (query_result as AnyObject).doubleValue(for: HKUnit.count())
                promise(.success(step))
            }
            self.healthStore.execute(query)
        }
    }
    
    func requestPostIsLaunch(isLaunch: Bool) -> Future<String, Error> {
        Future { promise in
            self.api.request(TeePodAPI.isLight(isLaunch: isLaunch)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try response.map(String.self)
                        promise(.success(json))
                    } catch {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    dump(error.errorDescription)
                    promise(.failure(error))
                }
            }
        }
    }
    
    func requestPostModeColor(mode: String) -> Future<String, Error> {
        Future { promise in
            self.api.request(TeePodAPI.returnColor(color: mode)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try response.map(String.self)
                        promise(.success(json))
                    } catch {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    dump(error.errorDescription)
                    promise(.failure(error))
                }
            }
        }
    }
}
