//
//  ModeCheck.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/02.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

func getMode()->String{
    let warning_border = 60     //min
    let current_time:Date = Date()
    let paripi_time:Date =  Calendar.current.date(byAdding: .hour, value: 0, to:current_time)!
    let remaining_time:Int = Int(current_time.timeIntervalSince(paripi_time)/60)
    var mode:String = ""
    
    if(remaining_time <= 0){
        mode = "paripi"
    }else if(0<remaining_time&&remaining_time<=warning_border){
        mode = "warning"
    }else if(warning_border<remaining_time){
        mode = "nomal"
    }
    return mode
}


func getModeColor()->Array<UIColor>{
    var mode_colors:[UIColor] = []
    let current_mode:String = getMode()
    
    if(current_mode == "paripi"){
        mode_colors = [UIColor.ModeColors.paripi[0],UIColor.ModeColors.paripi[1]]
    }else if(current_mode == "warning"){
        mode_colors = [UIColor.ModeColors.warning]
    }else if(current_mode == "nomal"){
        mode_colors = [UIColor.ModeColors.nomal]
    }
    return mode_colors
}
