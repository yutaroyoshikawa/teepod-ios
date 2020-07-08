//
//  ModeCheck.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/02.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

func judgeMode(paripi_time: Date) -> String {
    let warning_border = 30 // min
    let current_time: Date = Date()
    
    let remaining_time: Int = Int(paripi_time.timeIntervalSince(current_time) / 60)
    var mode: String = ""
    
    if remaining_time <= 0 {
        mode = "paripi"
    } else if remaining_time > 0, remaining_time <= warning_border {
        mode = "warning"
    } else if warning_border < remaining_time {
        mode = "nomal"
    }
    return mode
}

func judgeModeColor(mode: String) -> [UIColor] {
    var mode_colors: [UIColor] = []
    let current_mode: String = mode
    
    if current_mode == "paripi" {
        mode_colors = [UIColor.ModeColors.paripi[0], UIColor.ModeColors.paripi[1]]
    } else if current_mode == "warning" {
        mode_colors = [UIColor.ModeColors.warning]
    } else if current_mode == "nomal" {
        mode_colors = [UIColor.ModeColors.nomal]
    }
    return mode_colors
}

func getModeColor(mode: String) -> [UIColor] {
    var mode_colors: [UIColor] = []
    let current_mode: String = mode
    
    if current_mode == "paripi" {
        mode_colors = [UIColor.ModeColors.paripi[0], UIColor.ModeColors.paripi[1]]
    } else if current_mode == "warning" {
        mode_colors = [UIColor.ModeColors.warning]
    } else if current_mode == "nomal" {
        mode_colors = [UIColor.ModeColors.nomal]
    }
    return mode_colors
}

func setParipiTime() {
    let userDefaults = UserDefaults.standard
    let current_time = Date()
    let paripi_time: Date = Calendar.current.date(byAdding: .minute, value: +60, to: current_time)!
    UserDefaults.standard.removeAll()
    userDefaults.set(paripi_time, forKey: "paripi_time")
    userDefaults.synchronize()
    return
}

func searchParipiTime() -> Date? {
    let value = UserDefaults.standard.object(forKey: "paripi_time")
    guard let paripi_time = value as? Date else {
        return nil
    }
    return paripi_time
}

func getParipiTime() -> Date {
    let judge = searchParipiTime()
    var result: Date
    if judge != nil {
        result = judge!
    } else {
        setParipiTime()
        result = getParipiTime()
    }
    return result
}

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
        return
    }
}
