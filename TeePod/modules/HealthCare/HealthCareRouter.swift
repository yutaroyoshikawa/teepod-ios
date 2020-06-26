//
//  HealthCareHealthCareRouter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 26/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class HealthCareRouter {  
  func build() -> HealthCareView {
    let presenter = HealthCarePresenter()
    let view = HealthCareView(presenter: presenter)

    return view
  }
}

extension HealthCareRouter {}
