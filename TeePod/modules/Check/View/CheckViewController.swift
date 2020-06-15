//
//  CheckCheckViewController.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, CheckViewInput {

    var output: CheckViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: CheckViewInput
    func setupInitialState() {
    }
}
