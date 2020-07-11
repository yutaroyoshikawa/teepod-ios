//
//  CheckRouter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

final class CheckRouter {
    func build() -> CheckView {
        let presenter = CheckPresenter()
        let view = CheckView(presenter: presenter)
        
        return view
    }
}

extension CheckRouter {
    func makeResultView(tiredness: Int) -> ResultView {
        ResultRouter().build(tiredness: tiredness)
    }
}
