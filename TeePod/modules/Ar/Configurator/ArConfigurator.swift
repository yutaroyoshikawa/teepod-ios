//
//  ArArConfigurator.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class ArModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ArViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ArViewController) {

        let router = ArRouter()

        let presenter = ArPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ArInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
