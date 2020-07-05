//
//  HomeView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI
import UIKit

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    let gradient_start = UnitPoint(x: 0, y: 0)
    let gradient_end = UnitPoint(x: 1, y: 1)
    
    var body: some View {
        ZStack {
            main_color.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    // power
                    ReloadButton()
                        .onTapGesture {
                            self.presenter.requestGetStepCount()
                        }
                    Spacer().frame(width: 20)
                }
                .padding(.top, 10.0)
                
                StepCircle(step: presenter.stepCount)
                    .padding(.top, -50.0)
                
                Spacer()
                // button wrap
                VStack(spacing: 20) {
                    // power
                    PowerButton(isLaunch: self.presenter.isLaunchLight).onTapGesture {
                        self.presenter.onTapPower()
                    }
                    // AR
                    self.presenter.arLink {
                        HomeButton(img_name: "AR")
                    }
                    // Check
                    self.presenter.checkLink {
                        HomeButton(img_name: "approve")
                    }
                } // button wrap - ZStack
                Spacer()
            } // ZStack
        } // VStack
        .navigationBarTitle(Text("Teepod"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.presenter.requestGetStepCount()
            getParipiTime()
        }) // ZStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    } // navigation view
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = HomePresenter()
        return Group {
            HomeView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            HomeView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
