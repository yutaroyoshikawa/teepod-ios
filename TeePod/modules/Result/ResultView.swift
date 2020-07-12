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
    @State var showMessage = false
    @State var isAnimation = false
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                if presenter.tiredness != nil {
                    ResultCircle(tiredness: presenter.tiredness!)
                        .padding(.top, -30.0)
                }
                
                Spacer().frame(height: 30)
                if showMessage && presenter.tiredness != nil {
                    VStack(alignment: .center) {
                        Text("+" + String(self.presenter.getExtensionTime()) + "分")
                            .font(.system(size: 50, weight: .bold, design: .default))
                        Spacer().frame(height: 10)
                        Text(self.presenter.getComment())
                    }
                    .transition(.asymmetric(insertion: AnyTransition.opacity.combined(with: .offset(y: 50)), removal: .opacity))
                }
            }
            .foregroundColor(font_color)
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1.0).delay(2)) {
                    self.showMessage.toggle()
                }
            }
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
        let presenter = ResultPresenter(tiredness: 100)
        return Group {
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
