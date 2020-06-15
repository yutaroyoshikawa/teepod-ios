//
//  CheckCheckInitializer.swift
//  teepod-ios
//
//  Created by yutaro on 15/06/2020.
//  Copyright © 2020 teepod. All rights reserved.
//

import UIKit

class CheckModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var checkViewController: CheckViewController!

    override func awakeFromNib() {

        let configurator = CheckModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: checkViewController)
    }

}
