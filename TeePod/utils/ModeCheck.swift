//
//  ModeCheck.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/02.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var nomal: UIColor  { return UIColor(red: 0, green: 0, blue: 255, alpha: 1) }
    static var warning: UIColor  { return UIColor(red: 0, green: 255, blue: 0, alpha: 1) }
    static var paripi: UIColor  { return UIColor(red: 255, green: 0, blue: 0, alpha: 1) }
}

class ModeCheck{
    //時間は全てminで計算
    let warning_border = 60
    
    func getMode()->String{
        let current_time:Date = Date()
        let paripi_time:Date =  Calendar.current.date(byAdding: .hour, value: 0, to:current_time)!
        let remaining_time:Int = Int(current_time.timeIntervalSince(paripi_time)/60)
        var mode:String = ""
        
        if(remaining_time <= 0){
            mode = "paripi"
        }else if(0<remaining_time&&remaining_time<=self.warning_border){
            mode = "warning"
        }else if(self.warning_border<remaining_time){
            mode = "nomal"
        }
        return mode
    }

    func getModeColor()->UIColor{
        var mode_color:UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        let current_mode:String = getMode()

        if(current_mode == "paripi"){
            mode_color = UIColor.paripi
        }else if(current_mode == "warning"){
            mode_color = UIColor.warning
        }else if(current_mode == "nomal"){
            mode_color = UIColor.nomal
        }
        return mode_color
    }
}
