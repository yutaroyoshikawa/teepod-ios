//
//  ResultResultInteractor.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Combine
import Foundation

final class ResultInteractor {
    private let modeCheck = ModeCheck()
    
    func requestExtentionParipiTime() {
        modeCheck.extensionParipiTime()
    }
}
