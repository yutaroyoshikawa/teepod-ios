//
//  ArView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI


struct ArView: View {
    @ObservedObject var presenter: ArPresenter
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                CALayerView(caLayer: avFoundationVM.previewLayer)
            }.onAppear {
                self.avFoundationVM.startSession()
            }.onDisappear {
                self.avFoundationVM.endSession()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
        }
    }}

struct ArView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = ArPresenter()
        return Group{
            ArView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            ArView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
