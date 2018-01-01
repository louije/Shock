//
//  AppDelegate.swift
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var initialString: String?
    var windowController: TransparentWindowController?
    var shockController: ShockController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.set(true, forKey: "WebKitDeveloperExtras")
        UserDefaults.standard.synchronize()
        NSApplication.shared.setActivationPolicy(.regular)
        
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.count > 1 {
            initialString = String(arguments.dropFirst().joined(separator: " "))
            print("Initial in Delegate: \(String(describing: self.initialString))")
        }

        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let mainWindow = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "MainWindow")) as! TransparentWindowController
        
        print(mainWindow)
        mainWindow.showWindow(self)
        mainWindow.window?.makeKeyAndOrderFront(self)

        self.windowController = mainWindow

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

