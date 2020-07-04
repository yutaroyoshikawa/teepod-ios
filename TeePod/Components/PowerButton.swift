//
//  PowerButton.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/06/21.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct PowerButton: View {
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let pressed_font_color = Color(UIColor.MyThema.pressed_font_color)
    let pressed_shadow_color = Color(UIColor.MyThema.pressed_shadow_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    let gradient_start = UnitPoint.init(x: 0, y: 0)
    let gradient_end = UnitPoint.init(x: 1, y: 1)
    
    let isLaunch: Bool
    
    var body: some View {
        VStack{
            if(isLaunch) {
                Circle()
                    .fill(main_color)
                    .frame(width:90,height:90)
                    .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                    .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                    
                    .overlay(Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors:[Color(red:195/255,green:202/255,blue:210/255),Color(red:249/255,green:255/255,blue:255/255)]), startPoint: gradient_start, endPoint: gradient_end
                        ))
                        .frame(width: 80, height: 80)
                )
                    .overlay(
                        Image(systemName: "power")
                            .foregroundColor(pressed_font_color)
                            .font(.system(size: 30))
                            .shadow(color: pressed_shadow_color, radius: 7, x: 0, y: 0))
            } else {
                Circle()
                    .fill(main_color)
                    .frame(width:90,height:90)
                    .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                    .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                    .overlay(Circle()
                        .fill(main_color)
                        .frame(width: 80, height: 80)
                )
                    .overlay(
                        Image(systemName: "power")
                            .foregroundColor(Color(red:100/255,green:100/255,blue:100/255))
                            .font(.system(size: 30))
                )
            }
        }
    }
}

struct PowerButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            PowerButton(isLaunch: true)
            PowerButton(isLaunch: false)
        }
    }
}
