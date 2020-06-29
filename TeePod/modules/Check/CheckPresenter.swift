//
//  CheckPresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class CheckPresenter: ObservableObject {
    private let router = CheckRouter()
    private let interactor = CheckInteractor()
}

extension CheckPresenter {
}

extension CheckPresenter {
    func resultLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: self.router.makeResultView()) {
            content()
        }
    }
}
