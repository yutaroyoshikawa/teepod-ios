//
//  CheckView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

let main_color = Color(red: 233/255, green: 241/255, blue: 250/255)
let shadow_light = Color(red: 207/255, green: 215/255, blue: 224/255)
let shadow_dark = Color(red: 255/255, green: 255/255, blue: 255/255)


struct CheckView: View {
    @ObservedObject var presenter: CheckPresenter
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    
    var body: some View {
        ZStack{
            main_color.edgesIgnoringSafeArea(.all)
            VStack {
                
                ZStack() {
                    Rectangle()
                        .fill(main_color)
                        .frame(width:screenWidth-30,height:screenHeight*2/3)
                        .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
                        .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
                    
                    ZStack() {
                        CALayerView(caLayer: avFoundationVM.previewLayer)
                            .frame(width:screenWidth,height:screenHeight)
                        
                    }
                    .onAppear {
                        self.avFoundationVM.startSession()
                    }
                    .onDisappear {
                        self.avFoundationVM.endSession()
                    }
                    .frame(width:screenWidth,height:screenHeight*1/3)
                    .padding(.top,-30.0)
                }
                .padding(.top, 15.0)
                
                Spacer()
                Text("疲れ度が低ければカウントダウンを延長します")
                    .foregroundColor(Color(red:88/255,green:88/255,blue:88/255))
                
                Spacer()
            }
            .navigationBarTitle(Text("診断中"), displayMode: .inline)
            
        }
    }
    
    
    struct CheckView_Previews: PreviewProvider {
        static var previews: some View {
            let presenter = CheckPresenter()
            return Group{
                CheckView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
                CheckView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
            }
        }
    }
}
