//
//  ModeCheck.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/07/02.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import UIKit

enum Mode: String {
    case paripi
    case warning
    case normal
}

func judgeMode(paripi_time: Date) -> Mode {
    let warning_border = 30 // min
    let current_time: Date = Date()
    
    let remaining_time: Int = Int(paripi_time.timeIntervalSince(current_time) / 60)
    
    if remaining_time <= 0 {
        return Mode.paripi
    }
    
    if remaining_time > 0, remaining_time <= warning_border {
        return Mode.warning
    }
    
    return Mode.normal
}

func judgeModeColor(mode: Mode) -> [UIColor] {
    switch mode {
    case Mode.paripi:
        return [UIColor.ModeColors.paripi[0], UIColor.ModeColors.paripi[1]]
    case Mode.warning:
        return [UIColor.ModeColors.warning]
    case Mode.normal:
        return [UIColor.ModeColors.nomal]
    }
}

func getModeColor(mode: Mode) -> [UIColor] {
    switch mode {
    case Mode.paripi:
        return [UIColor.ModeColors.paripi[0], UIColor.ModeColors.paripi[1]]
    case Mode.warning:
        return [UIColor.ModeColors.warning]
    case Mode.normal:
        return [UIColor.ModeColors.nomal]
    }
}

func setParipiTime() {
    let userDefaults = UserDefaults.standard
    let current_time = Date()
    let paripi_time: Date = Calendar.current.date(byAdding: .minute, value: +60, to: current_time)!
    UserDefaults.standard.removeParipiTime()
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
    
    if judge != nil {
        return judge!
    }
    
    setParipiTime()
    return getParipiTime()
}

func extensionParipiTime() {
    let userDefaults = UserDefaults.standard
    let current_paripi_time: Date = getParipiTime()
    let new_paripi_time: Date = Calendar.current.date(byAdding: .minute, value: +10, to: current_paripi_time)!
    UserDefaults.standard.removeParipiTime()
    userDefaults.set(new_paripi_time, forKey: "paripi_time")
    userDefaults.synchronize()
    return
}

extension UserDefaults {
    func removeParipiTime() {
        UserDefaults.standard.removeObject(forKey: "paripi_time")
    }
}
