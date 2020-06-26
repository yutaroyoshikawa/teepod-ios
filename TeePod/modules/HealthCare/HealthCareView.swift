//
//  HealthCareHealthCareView.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 26/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import SwiftUI
import HealthKit
import RealmSwift

struct HealthCareView: View {
    @ObservedObject var presenter: HealthCarePresenter
    
    var body: some View {
        VStack{
            Text(self.presenter.comment)
            
            Button(action: {
                self.presenter.onTapButton()                
            })
            {
                // ボタンのテキスト
                Text("Button")
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
            }
        }
    }
}


struct HealthCareView_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = HealthCarePresenter()
        return Group{
            HealthCareView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
            HealthCareView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
        }
    }
}
