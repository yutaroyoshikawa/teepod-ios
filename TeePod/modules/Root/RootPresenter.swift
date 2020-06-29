//
//  RootRootPresenter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 29/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RootPresenter: ObservableObject {
  private let router = RootRouter()
  private let interactor = RootInteractor()
  
  let objectWillChange = ObservableObjectPublisher()
}

extension RootPresenter {}

extension RootPresenter {}
