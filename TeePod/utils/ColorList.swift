//
//  ColorList.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/03.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    struct MyThema{
        static var main_color: UIColor  { return UIColor(red: 233/255.0, green: 241/255.0, blue: 250/255.0, alpha: 1.0) }
        static var font_color: UIColor  { return UIColor(red: 88/255.0, green: 88/255.0, blue: 88/255.0, alpha: 1.0) }
        static var pressed_font_color: UIColor  { return UIColor(red: 82/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.0) }
        static var pressed_shadow_color: UIColor  { return UIColor(red: 0/255.0, green: 158/255.0, blue: 250/255.0, alpha: 1.0) }
        static var shadow_dark: UIColor  { return UIColor(red: 207/255.0, green: 215/255.0, blue: 224/255.0, alpha: 1.0) }
        static var shadow_light: UIColor  { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
    }
    struct ModeColors{
        static var nomal: UIColor  { return UIColor(red: 0, green: 0, blue: 255, alpha: 1) }
        static var warning: UIColor  { return UIColor(red: 0, green: 255, blue: 0, alpha: 1) }
        static var paripi:[UIColor] = [UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0),UIColor(red: 255/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)]
    }
}
