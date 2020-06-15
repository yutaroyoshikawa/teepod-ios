//
//  CheckCheckConfigurator.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class CheckModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CheckViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: CheckViewController) {

        let router = CheckRouter()

        let presenter = CheckPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CheckInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
