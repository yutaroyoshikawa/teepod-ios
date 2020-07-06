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
    case returnColor(color: String)
}

extension TeePodAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://us-central1-tee-pod.cloudfunctions.net")!
    }
    
    public var path: String {
        switch self {
        case .isLight:
            return "/isLight"
        case .returnColor:
            return "/returnColor"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .isLight:
            return .post
        case .returnColor:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .isLight(isLaunch):
            return .requestParameters(
                parameters: [
                    "launch": isLaunch
                ],
                encoding: URLEncoding.default
            )
        case let .returnColor(color):
            return .requestParameters(
                parameters: [
                    "color": color
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
