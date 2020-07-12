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
    
    @Published var tiredness: Int? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    func updateTiredness(tiredness: Int) {
        DispatchQueue.main.async {
            self.tiredness = tiredness
        }
    }
    
    init(tiredness: Int) {
        updateTiredness(tiredness: tiredness)
    }
}

extension ResultPresenter {
    func getComment() -> String {
        var comment: String
        if tiredness! <= 60 {
            comment = "時間が延長されました"
        } else {
            comment = "適度に休憩を取りましょう"
        }
        return comment
    }
    
    func getExtensionTime() -> Int {
        var extension_time: Int
        if tiredness! <= 60 {
            extension_time = 10
            extensionParipiTime()
        } else {
            extension_time = 0
        }
        return extension_time
    }
}

extension ResultPresenter {
    func homeLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeHomeView()) {
            content()
        }
    }
}
