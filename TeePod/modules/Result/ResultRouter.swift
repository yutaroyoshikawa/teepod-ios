//
//  ResultResultRouter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class ResultRouter {  
  func build() -> ResultView {
    let presenter = ResultPresenter()
    let view = ResultView(presenter: presenter)

    return view
  }
}

extension ResultRouter {}
