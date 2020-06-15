//
//  ArArInitializer.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class ArModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var arViewController: ArViewController!

    override func awakeFromNib() {

        let configurator = ArModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: arViewController)
    }

}
