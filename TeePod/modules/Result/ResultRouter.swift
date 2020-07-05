//
//  ResultResultRouter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class ResultRouter {
    func build() -> ResultView {
        let presenter = ResultPresenter()
        let view = ResultView(presenter: presenter)
        
        return view
    }
}

extension ResultRouter {
    func makeHomeView() -> HomeView {
        HomeRouter().build()
    }
}
