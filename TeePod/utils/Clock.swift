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
    private let formatter = DateFormatter()
    var timer: Timer?
    
    init() {
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.setLocalizedDateFormatFromTemplate("jms")
        time = formatter.string(from: Date())
    }
    
    func start() {
        print(time)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.time = self.formatter.string(from: Date())
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
