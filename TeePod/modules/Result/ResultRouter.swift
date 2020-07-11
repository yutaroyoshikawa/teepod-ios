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
    func build(tiredness: Int) -> ResultView {
        let presenter = ResultPresenter(tiredness: tiredness)
        let view = ResultView(presenter: presenter)
        
        return view
    }
}

extension ResultRouter {
    func makeHomeView() -> HomeView {
        HomeRouter().build()
    }
}
