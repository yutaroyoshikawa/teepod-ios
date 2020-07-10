//
//  resultCircle.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/08.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct ResultCircle: View {
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    
    @State var circleProgress: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            Circle()
                .fill(main_color)
                .frame(width: screenWidth * 2 / 3 + 20, height: screenWidth * 2 / 3 + 20)
                .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
            
            ZStack {
                Circle()
                    .stroke(shadow_dark, style: StrokeStyle(lineWidth: 12, lineCap: CGLineCap.round))
                    .frame(width: screenWidth * 2 / 3 - 15, height: screenWidth * 2 / 3 - 15)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(circleProgress, 1.0)))
                    .stroke(Color.pink, style: StrokeStyle(lineWidth: 12, lineCap: CGLineCap.round))
                    .frame(width: screenWidth * 2 / 3 - 15, height: screenWidth * 2 / 3 - 15)
                    .rotationEffect(.degrees(-90)) // Start from top
                
                VStack {
                    Text("疲れ度")
                    Spacer().frame(height: 10)
                    HStack(alignment: .bottom) {
                        Text("100")
                            .font(.system(size: 50, weight: .bold, design: .default))
                        Text("/100")
                            .font(.title)
                    }
                }
                .padding(.top, -20.0)
            }
        }
    }
}

struct ResultCircle_Previews: PreviewProvider {
    static var previews: some View {
        ResultCircle()
    }
}
