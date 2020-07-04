//
//  CheckView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

let main_color = Color(UIColor.MyThema.main_color)
let font_color = Color(UIColor.MyThema.font_color)
let shadow_light = Color(UIColor.MyThema.shadow_light)
let shadow_dark = Color(UIColor.MyThema.shadow_dark)

struct CheckView: View {
    @ObservedObject var presenter: CheckPresenter
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Rectangle()
                        .fill(main_color)
                        .frame(width: screenWidth - 30, height: screenHeight * 2 / 3)
                        .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                        .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                    
                    ZStack {
                        CALayerView(caLayer: avFoundationVM.previewLayer)
                            .frame(width: screenWidth, height: screenHeight)
                    }
                    .onAppear {
                        self.avFoundationVM.startSession()
                    }
                    .onDisappear {
                        self.avFoundationVM.endSession()
                    }
                    .frame(width: screenWidth, height: screenHeight * 1 / 3)
                    .padding(.top, -30.0)
                }
                .padding(.top, 15.0)
                
                Spacer()
                Text("疲れ度が低ければカウントダウンを延長します")
                    .foregroundColor(font_color)
                
                Spacer()
                
                self.presenter.resultLink {
                    Text("診断結果")
                        .foregroundColor(font_color)
                }
                
                Spacer()
            }
            .navigationBarTitle(Text("診断中"), displayMode: .inline)
        }
    }
    
    struct CheckView_Previews: PreviewProvider {
        static var previews: some View {
            let presenter = CheckPresenter()
            return Group {
                CheckView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
                CheckView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
            }
        }
    }
}
