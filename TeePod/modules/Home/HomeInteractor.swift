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
    private let modeCheck = ModeCheck()
    
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
            let paripi_time: Date = self.modeCheck.getParipiTime()
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
                        let json = try response.mapString()
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
    
    func requestGetParipiTime() -> Date? {
        modeCheck.getParipiTime()
    }
    
    func requestSetParipiTime() {
        modeCheck.setParipiTime()
    }
    
    func requestGetMode(paripiTime: Date) -> Mode {
        modeCheck.judgeMode(paripi_time: paripiTime)
    }
    
    func requestGetModeColor(mode: Mode) -> [UIColor] {
        modeCheck.judgeModeColor(mode: mode)
    }
    
    func requestPostModeColor(mode: Mode) -> Future<String, Error> {
        Future { promise in
            self.api.request(TeePodAPI.changeColor(color: mode.rawValue)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try response.mapString()
                        dump(json)
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
    
    func setIsLaunch(isLaunch: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(isLaunch, forKey: "is_launch")
        userDefaults.synchronize()
    }
    
    private func searchIsLaunch() -> Bool? {
        let value = UserDefaults.standard.object(forKey: "is_launch")
        guard let is_launch = value as? Bool else {
            return nil
        }
        return is_launch
    }
    
    func getIsLaunch() -> Bool {
        let isLaunch = searchIsLaunch()
        
        if isLaunch != nil {
            return isLaunch!
        }
        
        setIsLaunch(isLaunch: false)
        return getIsLaunch()
    }
}
