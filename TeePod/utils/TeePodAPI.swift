//
//  TeePodAPI.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/07/05.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import Moya

public enum TeePodAPI {
    case isLight(isLaunch: Bool)
    case changeColor(color: String)
}

extension TeePodAPI: TargetType {
    public var baseURL: URL {
        URL(string: "https://us-central1-tee-pod-17291.cloudfunctions.net")!
    }
    
    public var path: String {
        switch self {
        case .isLight:
            return "/isLight"
        case .changeColor:
            return "/changeColor"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .isLight:
            return .post
        case .changeColor:
            return .post
        }
    }
    
    public var sampleData: Data {
        Data()
    }
    
    public var task: Task {
        switch self {
        case let .isLight(isLaunch):
            return .requestParameters(
                parameters: [
                    "launch": isLaunch
                ],
                encoding: JSONEncoding.default
            )
        case let .changeColor(color):
            return .requestParameters(
                parameters: [
                    "color": color
                ],
                encoding: JSONEncoding.default
            )
        }
    }
    
    public var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        .successCodes
    }
}
