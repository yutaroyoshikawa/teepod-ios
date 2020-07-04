//
//  RootRootView.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 29/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var presenter: RootPresenter
    private let view = HomeRouter().build()
    
    var body: some View {
        NavigationView {
            view
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = RootPresenter()
        return Group {
            RootView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            RootView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
