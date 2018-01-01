//
//  TransparentWindowController.swift
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

import Cocoa

class TransparentWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        guard let window = window else { return }
        window.setFrame(NSScreen.main!.frame, display: true)
        window.orderFront(self)

    }

}
