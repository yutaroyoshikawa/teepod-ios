//
//  ArView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import RealityKit
import SwiftUI

struct ArView: View {
    @ObservedObject var presenter: ArPresenter
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    CALayerView(
                        caLayer: presenter.previewLayer,
                        frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
                    )
                }
                .onAppear {
                    self.presenter.onAppearArView()
                }
                .onDisappear {
                    self.presenter.onDisappearArView()
                }
            }
            .navigationBarTitle(Text("AR"), displayMode: .inline)
        }
    }
    
    struct ArView_Previews: PreviewProvider {
        static var previews: some View {
            let presenter = ArPresenter()
            return Group {
                ArView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
                ArView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
            }
        }
    }
}
