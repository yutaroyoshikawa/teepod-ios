//
//  CheckView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct CheckView: View {
  @ObservedObject var presenter: CheckPresenter
  
    var body: some View {
        Text("This is Check page")
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
      let presenter = CheckPresenter()
      return CheckView(presenter: presenter)
    }
}
