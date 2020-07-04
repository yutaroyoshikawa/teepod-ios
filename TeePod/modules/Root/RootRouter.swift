//
//  RootRootRouter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 29/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class RootRouter {
    func build() -> RootView {
        let presenter = RootPresenter()
        let view = RootView(presenter: presenter)
        
        return view
    }
}

extension RootRouter {}
