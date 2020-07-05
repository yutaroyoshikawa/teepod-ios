//
//  ResultResultPresenter.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class ResultPresenter: ObservableObject {
    private let router = ResultRouter()
    private let interactor = ResultInteractor()
    
    let objectWillChange = ObservableObjectPublisher()
}

extension ResultPresenter {}

extension ResultPresenter {
    func homeLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeHomeView()) {
            content()
        }
    }
}
