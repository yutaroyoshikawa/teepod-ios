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
    @State private var isPushed = true
    @State var isAnimation = false
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Rectangle()
                        .fill(main_color)
                        .frame(width: screenWidth - 30, height: screenHeight * 2 / 3)
                        .cornerRadius(5)
                        .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                        .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                    
                    ZStack {
                        CALayerView(caLayer: presenter.previewLayer, frame: CGRect(x: 0, y: 0, width: screenWidth - 50, height: screenHeight * 2 / 3 - 20))
                            .frame(width: screenWidth - 50, height: screenHeight * 2 / 3 - 20)
                            .cornerRadius(5)
                        
                        if presenter.loading {
                            Rectangle()
                                .fill(Color(UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.5)))
                                .frame(width: screenWidth - 50, height: screenHeight * 2 / 3 - 20)
                                .cornerRadius(5)
                            
                            Image("logo")
                                .resizable()
                                .frame(width: 100, height: 100)
//                                .rotationEffect(Angle(degrees: self.isAnimation ? 360 : 0))
//                                .onAppear {
//                                    withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: false)) {
//                                        self.isAnimation.toggle()
//                                    }
//                                }.onDisappear {
//                                    self.isAnimation.toggle()
//                                }
                        } else {
                            ZStack {
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                                    .frame(width: 60, height: 60)
                                Image(systemName: "camera")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 30))
                            }
                            .padding(.top, 330)
                            .onTapGesture {
                                self.presenter.onTapCameraPreview()
                            }
                        }
                    }
                    .onAppear {
                        self.presenter.onAppearCameraPreview()
                    }
                    .onDisappear {
                        self.presenter.onDisappearCameraPreview()
                    }
                }
                .padding(.top, 15.0)
                Spacer()
                
                Text("疲れ度が低ければカウントダウンを延長します")
                    .foregroundColor(font_color)
                
                Spacer()
                
                if self.presenter.tiredness != nil {
                    self.presenter.resultLink(tiredness: Int(self.presenter.tiredness!), isActive: $isPushed) {
                        EmptyView()
                    }
                }
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
