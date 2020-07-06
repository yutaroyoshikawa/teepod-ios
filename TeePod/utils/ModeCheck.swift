//
//  ModeCheck.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/02.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

func getMode() -> String? {
    let warning_border = 30 // min
    let current_time: Date = Date()
    let paripi_time = getParipiTime()
    
    if type(of:paripi_time) == Date.self{
        let remaining_time: Int = Int(paripi_time!.timeIntervalSince(current_time) / 60)
        var mode: String = ""
        
        if remaining_time <= 0 {
            mode = "paripi"
        } else if remaining_time > 0, remaining_time <= warning_border {
            mode = "warning"
        } else if warning_border < remaining_time {
            mode = "nomal"
        }
        return mode
    }else{
        return nil
    }
}

func getModeColor() -> [UIColor] {
    var mode_colors: [UIColor] = []
    let current_mode = getMode()
    
    if current_mode == "paripi" {
        mode_colors = [UIColor.ModeColors.paripi[0], UIColor.ModeColors.paripi[1]]
    } else if current_mode == "warning" {
        mode_colors = [UIColor.ModeColors.warning]
    } else if current_mode == "nomal" {
        mode_colors = [UIColor.ModeColors.nomal]
    } else {
        mode_colors = [UIColor.ModeColors.error]
    }
    return mode_colors
}

func setParipiTime(){
    let userDefaults = UserDefaults.standard
    let current_time = Date()
    let paripi_time: Date = Calendar.current.date(byAdding: .minute, value: +60, to: current_time)!
    UserDefaults.standard.removeAll()
    userDefaults.set(paripi_time, forKey: "paripi_time")
    userDefaults.synchronize()
    return
}

@discardableResult func getParipiTime() -> Date?{
    let value = UserDefaults.standard.object(forKey: "paripi_time")
    guard let paripi_time = value as? Date else {
        setParipiTime()
        getParipiTime()
        return nil
    }
    return paripi_time
}

func getResetStep()->Int?{
    let current_step:Int = 0
    let border_step = 60
    let step:Int = border_step - current_step
    if(step<0){
        setParipiTime()
        return nil
    }else{
        return step
    }
}

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
        return
    }
}
