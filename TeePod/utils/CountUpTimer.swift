//
//  Interval.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/07/11.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation

class CountUpTimer: ObservableObject {
    @Published var counter: Int = 0
    var count: Int
    var interval: Double
    var timer: Timer?
    
    init(count: Int, interval: Double) {
        self.count = count
        self.interval = interval
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            self.counter += 1
            if self.count == self.counter {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
}
