//
//  ArPresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class ArPresenter: ObservableObject {
    private let router = ArRouter()
    private let interactor = ArInteractor()
    
    @Published var previewLayer: CALayer {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        previewLayer = interactor.setupAR()
    }
}

extension ArPresenter {}

extension ArPresenter {
    func onAppearArView() {
        interactor.startSettion()
    }
    
    func onDisappearArView() {
        interactor.stopSettion()
    }
}
