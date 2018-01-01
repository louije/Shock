//
//  TransparentWindow.swift
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

import Cocoa

class TransparentWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        backgroundColor = NSColor.clear
        level = .floating
        alphaValue = 1.0
        isOpaque = false
        hasShadow = false
        ignoresMouseEvents = false
    }
    
    override var canBecomeKey: Bool {
        return true
    }
}
