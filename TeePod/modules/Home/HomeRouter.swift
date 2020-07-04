//
//  HomeRouter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class HomeRouter {
    func build() -> HomeView {
        let presenter = HomePresenter()
        let view = HomeView(presenter: presenter)
        
        return view
    }
}

extension HomeRouter {
    func makeArView() -> ArView {
        return ArRouter().build()
    }
    
    func makeCheckView() -> CheckView {
        return CheckRouter().build()
    }
}
