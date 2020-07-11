//
//  ResultResultView.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var presenter: ResultPresenter
    
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    let gradient_start = UnitPoint(x: 0, y: 0)
    let gradient_end = UnitPoint(x: 1, y: 1)
    var result_min = 30
    var result_message = "カウントダウンが延長されました"
    @State var message_opacity: Double = 0.0
    @State var isAnimation = false
    
//    func opacityChange(){
//        message_opacity = 1.0
//    }
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                if presenter.tiredness != nil {
                    ResultCircle(tiredness: Int(presenter.tiredness!))
                        .padding(.top, -30.0)
                }
                
                Spacer().frame(height: 30)
                
                VStack(alignment: .center) {
                    Text("+" + String(result_min) + "分")
                        .font(.system(size: 50, weight: .bold, design: .default))
                    Spacer().frame(height: 10)
                    Text(result_message)
                }
                .opacity(message_opacity)
                .animation(Animation.easeInOut(duration: 2).delay(1.5))
                .transition(.opacity)
                .onAppear(
                    perform: {
                        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
                            self.message_opacity = 1.0
                        }
                        
                        //                    self.message_opacity = 1.0
                    }
                )
            }
            .foregroundColor(font_color)
        }
        .navigationBarTitle(Text("診断結果"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            self.presenter.homeLink {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(Font.system(.title))
                    Text("Teepod")
                }
            }
        )
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = ResultPresenter(tiredness: 100.0)
        return Group {
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
