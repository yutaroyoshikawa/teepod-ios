//
//  ParipiClock.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/07/11.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct ParipiClock: View {
    @ObservedObject var clock: Clock
//    @State var showMessage = false
    
    init() {
        let modeCheck = ModeCheck()
        clock = Clock(paripiTime: modeCheck.getParipiTime())
        clock.start()
    }
    
    var body: some View {
        VStack {
            Text("ぱりぴモードまであと")
                .font(.system(size: 40, weight: .black, design: .default))
            
//            if showMessage {
            VStack {
                Text(clock.time)
                    .font(.custom("CourierNewPS-BoldMT", size: 100))
            }
            .frame(width: 500)
            .transition(AnyTransition.opacity.combined(with: .scale))
//            }
        }
//        .onAppear {
//            withAnimation(Animation.easeOut(duration: 0.6).delay(2)) {
//                self.showMessage.toggle()
//            }
//        }
        .onDisappear {
            self.clock.stop()
        }
    }
}

struct ParipiClock_Previews: PreviewProvider {
    static var previews: some View {
        ParipiClock()
    }
}
