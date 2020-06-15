//
//  ArArViewController.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class ArViewController: UIViewController, ArViewInput {

    var output: ArViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: ArViewInput
    func setupInitialState() {
    }
}
