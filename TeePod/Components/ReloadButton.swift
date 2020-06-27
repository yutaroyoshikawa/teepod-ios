//
//  ReloadButton.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/06/27.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct ReloadButton: View {
    let main_color = Color(red: 233/255, green: 241/255, blue: 250/255)
    let shadow_light = Color(red: 207/255, green: 215/255, blue: 224/255)
    let shadow_dark = Color(red: 255/255, green: 255/255, blue: 255/255)

    var body: some View {
        Circle()
            .fill(main_color)
            .frame(width:50,height:50)
            .shadow(color: shadow_light, radius: 10, x: 10, y: 10)
            .shadow(color: shadow_dark, radius: 10, x: -5, y: -5)
            .overlay(
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color(red:100/255,green:100/255,blue:100/255))
                    .font(.system(size: 20))
                    .padding(.top,-5.0)
            )
    }
}

struct ReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        ReloadButton()
    }
}
