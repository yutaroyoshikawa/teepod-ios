//
//  FaceAPI.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/07/06.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import Moya

public enum FaceAPI {
    static let env = ProcessInfo.processInfo.environment
    
    case detect(imageData: Data)
}

extension FaceAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://teepod.cognitiveservices.azure.com")!
    }
    
    public var path: String {
        switch self {
        case .detect:
            return "/face/v1.0/detect"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .detect:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .detect(imageData):
            return .requestCompositeData(
                bodyData: imageData,
                urlParameters: [
                    "returnFaceId": "false",
                    "returnFaceLandmarks": "false",
                    "returnFaceAttributes": "smile,emotion"
                ]
            )
        }
    }
    
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/octet-stream",
            "Ocp-Apim-Subscription-Key": FaceAPI.env["FACE_API_KEY"]!
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

public struct FaceAPIReturnModel: Codable {
    let faceAttributes: Attribute
    
    struct Attribute: Codable {
        let smile: Float
        let emotion: Emotion
    }
    
    struct Emotion: Codable {
        let sadness: Float
        let anger: Float
        let happiness: Float
        let fear: Float
        let neutral: Float
        let surprise: Float
        let contempt: Float
        let disgust: Float
    }
}
