//
//  ResultResultView.swift
//  teepod-ios
//
//  Created by ChiekoIshii on 27/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import SwiftUI

struct ResultView: View {
  @ObservedObject var presenter: ResultPresenter
  
  var body: some View {
    Text("🐹へけ")
  }
}


struct ResultView_Previews: PreviewProvider {
  static var previews: some View {
    let presenter = ResultPresenter()
    return Group{
      ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7 Plus"))
      ResultView(presenter: presenter).previewDevice(PreviewDevice(rawValue: "iPhone 7"))
    }
  }
}
