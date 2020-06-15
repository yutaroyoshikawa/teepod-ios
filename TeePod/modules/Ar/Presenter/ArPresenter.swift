//
//  ArArPresenter.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

class ArPresenter: ArModuleInput, ArViewOutput, ArInteractorOutput {

    weak var view: ArViewInput!
    var interactor: ArInteractorInput!
    var router: ArRouterInput!

    func viewIsReady() {

    }
}
