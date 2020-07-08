//
//  StepCircle.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/03.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI
import UIKit

struct StepCircle: View {
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let pressed_font_color = Color(UIColor.MyThema.pressed_font_color)
    let pressed_shadow_color = Color(UIColor.MyThema.pressed_shadow_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    let gradient_start = UnitPoint(x: 0, y: 0)
    let gradient_end = UnitPoint(x: 1, y: 1)
    // data
    let step: Int
    let mode: String
    let mode_color: [UIColor]
    
    var body: some View {
        ZStack {
            if mode == "paripi" {
                Circle()
                    .fill(main_color)
                    .frame(width: screenWidth / 2 + 40, height: screenWidth / 2 + 40)
                    .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                    .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(mode_color[0]), Color(mode_color[1])]), startPoint: .top, endPoint: .bottom
                        )
                    )
                    .frame(width: screenWidth / 2 + 20, height: screenWidth / 2 + 20)
                
                Text("Walk " + String(step) + " steps")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
            } else {
                Circle()
                    .fill(main_color)
                    .frame(width: screenWidth / 2 + 40, height: screenWidth / 2 + 40)
                    .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                    .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
                
                Circle()
                    .fill(Color(mode_color[0]))
                    .frame(width: screenWidth / 2 + 20, height: screenWidth / 2 + 20)
                
                Text("Walk " + String(step) + " steps")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct StepCircle_Previews: PreviewProvider {
    static var previews: some View {
        StepCircle(step: 0, mode: "", mode_color: [])
    }
}
