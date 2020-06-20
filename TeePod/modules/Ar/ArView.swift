//
//  ArView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct ArView: View {
  @ObservedObject var presenter: ArPresenter
  
    var body: some View {
        Text("This is AR page")
    }
}

struct ArView_Previews: PreviewProvider {
    static var previews: some View {
      let presenter = ArPresenter()
      return ArView(presenter: presenter)
    }
}
