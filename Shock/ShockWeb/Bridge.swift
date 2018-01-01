//
//  Bridge.swift
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 29/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

import Foundation
import WebKit

@objc class Bridge : NSObject {

    override class func isSelectorExcluded(fromWebScript selector: Selector!) -> Bool {
        if selector == #selector(Bridge.quit) {
            return false
        }
        return true
    }
    
    override class func webScriptName(for selector: Selector!) -> String! {
        if selector == #selector(Bridge.quit) {
            return "quit"
        }
        return nil
    }

    
    @objc func quit(e: Any?) {
        print("Quitting. \(String(describing: e))")
        NSApplication.shared.terminate(self)
    }
    
}
