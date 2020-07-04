//
//  ArRouter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class ArRouter {
    func build() -> ArView {
        let presenter = ArPresenter()
        let view = ArView(presenter: presenter)
        
        return view
    }
}

extension ArRouter {}
