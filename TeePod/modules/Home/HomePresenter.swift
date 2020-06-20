//
//  HomePresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class HomePresenter: ObservableObject {
  private let router = HomeRouter()
  private let interactor = HomeInteractor()
}

extension HomePresenter {
}

extension HomePresenter {
  func arLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
      return NavigationLink(destination: self.router.makeArView()) {
          content()
      }
  }
  
  func checkLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
      return NavigationLink(destination: self.router.makeCheckView()) {
          content()
      }
  }
}
