//
//  HomeButton.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/03.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct HomeButton: View {
    let main_color = Color(UIColor.MyThema.main_color)
    let font_color = Color(UIColor.MyThema.font_color)
    let shadow_light = Color(UIColor.MyThema.shadow_light)
    let shadow_dark = Color(UIColor.MyThema.shadow_dark)
    var img_name:String = ""

    var body: some View {
        Circle()
            .fill(main_color)
            .frame(width: 90, height: 90)
            .shadow(color: shadow_dark, radius: 10, x: 10, y: 10)
            .shadow(color: shadow_light, radius: 10, x: -5, y: -5)
            .overlay(
                Image(img_name)
                    .foregroundColor(font_color)
        )
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton()
    }
}
