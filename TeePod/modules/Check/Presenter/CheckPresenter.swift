//
//  CheckCheckPresenter.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

class CheckPresenter: CheckModuleInput, CheckViewOutput, CheckInteractorOutput {

    weak var view: CheckViewInput!
    var interactor: CheckInteractorInput!
    var router: CheckRouterInput!

    func viewIsReady() {

    }
}
