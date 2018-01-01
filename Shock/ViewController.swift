//
//  ViewController.swift
//  Shock
//
//  Created by Louis-Jean Teitelbaum on 28/12/2017.
//  Copyright © 2017 Meidosem. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, ShockController {

    @IBOutlet weak var webView: WebView!
    var delegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = NSApplication.shared.delegate as? AppDelegate
        
//        webView.editingDelegate = self
        webView.uiDelegate = self
        webView.resourceLoadDelegate = self
        
        let source = URL(fileURLWithPath: Bundle.main.path(forResource: "ShockWeb", ofType: "html")!)
        // let resourcesUrl = URL(fileURLWithPath: Bundle.main.resourcePath!, isDirectory: true)
        
        let request = URLRequest(url: source)
        
        let global = webView.windowScriptObject
        // let bridge = ShockWebBridge() // Obj-C
        let bridge = Bridge()
        global?.setValue(bridge, forKey: "Bridge")
        
        webView.drawsBackground = false
        webView.mainFrame.load(request)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setMessage(_ message: String) {
        webView.stringByEvaluatingJavaScript(from: "ShockView.set('\(message)')")
    }
    
    func clearMessage() {
        webView.stringByEvaluatingJavaScript(from: "ShockView.clear()")
    }
    
    override func cancelOperation(_ sender: Any?) {
        // Precents escape key from beeping. Escape key is dealt with in JS.
    }
}

extension ViewController: WebUIDelegate {
    func webView(_ webView: WebView!, shouldPerformAction action: Selector!, fromSender sender: Any!) -> Bool {
        print(action)
        print(sender)
        return true
    }
}

extension ViewController: WebResourceLoadDelegate {
    func webView(_ sender: WebView!, resource identifier: Any!, didFinishLoadingFrom dataSource: WebDataSource!) {
        guard let initialString = delegate?.initialString else { return }
        setMessage(initialString)
    }
}

