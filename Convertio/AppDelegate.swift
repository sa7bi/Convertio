//
//  AppDelegate.swift
//  Convertio
//
//  Created by sahbi.alhajbel on 24.05.16.
//  Copyright © 2016 sahbi.alhajbel. All rights reserved.
//

import Cocoa
import Fabric
import Crashlytics

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	// Variables
	let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
	let popover = NSPopover()
	@IBOutlet weak var statusMenu: NSMenu!
	
	// MARK: Handle Popover Actions
	func showPopover(sender: AnyObject?) {
		if let button = statusItem.button {
			popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
		}
	}
 
	func closePopover(sender: AnyObject?) {
		popover.performClose(sender)
	}
 
	func togglePopover(sender: AnyObject?) {
		if popover.shown {
			closePopover(sender)
		} else {
			showPopover(sender)
		}
	}
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
//		let styleMode = NSUserDefaults.standardUserDefaults().stringForKey("AppleInterfaceStyle")
//		print("OS X Mode: \(styleMode)")
		Fabric.with([Crashlytics.self])
		NSUserDefaults.standardUserDefaults().registerDefaults(["NSApplicationCrashOnExceptions" : true])
		// Insert code here to initialize your application
		let image = NSImage(named: "menubar_icon")
		image?.template = true
		statusItem.image = image
		//statusItem.title = "Convertio"

		if let button = statusItem.button {
			button.action = #selector(AppDelegate.togglePopover(_:))
		}
		//statusItem.menu = statusMenu
		popover.contentViewController = ConvertioController(nibName: "ConvertioController", bundle: nil)
		
	}
	
	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
	
	@IBAction func processInput(sender: NSTextField) {
		print("User has typed: \(sender.stringValue)")
	}
	@IBAction func quitBtn(sender: AnyObject) {
		NSApplication.sharedApplication().terminate(self)
	}
	
}

