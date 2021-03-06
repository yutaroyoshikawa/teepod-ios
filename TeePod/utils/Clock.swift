//
//  Clock.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/07/12.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation

class Clock: ObservableObject {
    @Published var time: String
    private var stopFlag = false
    private let paripiTime: Date
    private let formatter = DateComponentsFormatter()
    var timer: Timer?
    
    init(paripiTime: Date) {
        self.paripiTime = paripiTime
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .hour, .second]
        time = formatter.string(from: paripiTime.timeIntervalSinceNow)!
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.time = self.formatter.string(from: self.paripiTime.timeIntervalSinceNow)!
            if self.stopFlag {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
    
    func stop() {
        stopFlag = true
    }
}
