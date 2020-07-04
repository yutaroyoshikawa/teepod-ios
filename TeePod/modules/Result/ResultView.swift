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
    var result_score = 100
    var result_min = 30
    var result_message = "カウントダウンが延長されました"
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(main_color)
                        .frame(width: screenWidth * 2 / 3 + 20, height: screenWidth * 2 / 3 + 20)
                        .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                        .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                    
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.pink, Color.yellow]), startPoint: .top, endPoint: .bottom
                        ))
                        .frame(width: screenWidth * 2 / 3, height: screenWidth * 2 / 3)
                    
                    Circle()
                        .fill(main_color)
                        .frame(width: screenWidth * 2 / 3 - 20, height: screenWidth * 2 / 3 - 20)
                    
                    VStack {
                        Text("疲れ度")
                        Spacer().frame(height: 10)
                        HStack(alignment: .bottom) {
                            Text(String(result_score))
                                .font(.system(size: 50, weight: .bold, design: .default))
                            Text("/100")
                                .font(.title)
                        }
                    }
                    .padding(.top, -20.0)
                }
                .padding(.top, -30.0)
                
                Spacer().frame(height: 30)
                Text("+" + String(result_min) + "分")
                    .font(.system(size: 50, weight: .bold, design: .default))
                Spacer().frame(height: 10)
                Text(result_message)
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
        let presenter = ResultPresenter()
        return Group {
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
