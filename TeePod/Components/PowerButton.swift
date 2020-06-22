//
//  PowerButton.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/06/21.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct PowerButton: View {
  let main_color = Color(red: 233/255, green: 241/255, blue: 250/255)
  let shadow_light = Color(red: 207/255, green: 215/255, blue: 224/255)
  let shadow_dark = Color(red: 255/255, green: 255/255, blue: 255/255)
  let gradient_start = UnitPoint.init(x: 0, y: 0)
  let gradient_end = UnitPoint.init(x: 1, y: 1)
  let hamutaro = Color(red:0/255,green:158/255,blue:250/255)
  
  let isLaunch: Bool
  
  var body: some View {
    VStack{
      if(isLaunch) {
        Circle()
          .fill(main_color)
          .frame(width:90,height:90)
          .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
          .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
          
          
          .overlay(Circle()
            .fill(LinearGradient(
              gradient: Gradient(colors:[Color(red:195/255,green:202/255,blue:210/255),Color(red:249/255,green:255/255,blue:255/255)]), startPoint: gradient_start, endPoint: gradient_end
            ))
            .frame(width: 80, height: 80)
        )
          .overlay(
            Image(systemName: "power")
              .foregroundColor(Color(red:82/255,green:191/255,blue:255/255))
              .font(.system(size: 30))
              .shadow(color: hamutaro, radius: 7, x: 0, y: 0))
      } else {
        Circle()
          .fill(main_color)
          .frame(width:90,height:90)
          .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
          .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
          
          
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
