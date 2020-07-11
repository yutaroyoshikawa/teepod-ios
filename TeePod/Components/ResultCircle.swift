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
    let result_groove_base = Color(UIColor.MyThema.result_groove_base)
    let result_groove_shadow = Color(UIColor.MyThema.result_groove_shadow)
    let result_gauge = Color(UIColor.MyThema.result_gauge)
    let circle_progress: CGFloat = 0.3
    @State var animation_flag = false
    @State var tiredness_count: Int = 0
    @State var countup_flag: Bool = true
    let tiredness: Int = 30
    var interval: Double
    var timer: Timer
    init() {
        interval = 2.0 / Double(tiredness)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if self.tiredness_count < self.tiredness {
                self.tiredness_count += 1
                print("kero")
            } else {
                self.timer.invalidate()
                print("hamu")
            }
            return
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(main_color)
                .frame(width: screenWidth * 2 / 3 + 20, height: screenWidth * 2 / 3 + 20)
                .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
                .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
            
            ZStack {
                Circle()
                    .stroke(result_groove_base, style: StrokeStyle(lineWidth: 12, lineCap: CGLineCap.round))
                    .frame(width: screenWidth * 2 / 3 - 15, height: screenWidth * 2 / 3 - 15)
                
                Circle()
                    .trim(from: 0.0, to: animation_flag ? CGFloat(min(circle_progress, 1.0)) : 0.0)
                    .stroke(result_gauge, style: StrokeStyle(lineWidth: 12, lineCap: CGLineCap.round))
                    .frame(width: screenWidth * 2 / 3 - 15, height: screenWidth * 2 / 3 - 15)
                    .rotationEffect(.degrees(-90)) // Start from top
                    .animation(.easeOut(duration: 2))
                            .onAppear {
                        self.animation_flag.toggle()
                    }
                
                VStack {
                    Text("疲れ度")
                    Spacer().frame(height: 10)
                    HStack(alignment: .bottom) {
                        Text(String(tiredness_count))
                            .font(.system(size: 50, weight: .bold, design: .default))
                        Text("/100")
                            .font(.title)
                    }
                }
                .padding(.top, -20.0)
            }
        }
    }
    
    func tirednessCountup() {
        if tiredness_count < tiredness {
            tiredness_count += 1
            print("kero")
        } else {
            self.timer.invalidate()
            print("hamu")
        }
        return
    }
}

struct ResultCircle_Previews: PreviewProvider {
    static var previews: some View {
        ResultCircle()
    }
}
