//
//  ConvertioController.swift
//  Convertio
//
//  Created by sahbi.alhajbel on 24.05.16.
//  Copyright © 2016 sahbi.alhajbel. All rights reserved.
//

import Cocoa

class ConvertioController: NSViewController, CurrencyDelegate {
	
	@IBOutlet weak var baseFlag: NSTextField!
	@IBOutlet weak var baseNumber: NSTextField!
	@IBOutlet weak var destFlag: NSTextField!
	@IBOutlet weak var destNumber: NSTextField!
	
	@IBOutlet weak var errorLabel: NSTextField!
	@IBOutlet weak var quitBtn: NSButton!
	@IBOutlet weak var destCurrencyLabel: NSTextField!
	@IBOutlet weak var baseCurrencyLabel: NSTextField!
	@IBOutlet weak var placeholder: NSImageView!
	@IBOutlet weak var progressIndicator: NSProgressIndicator!
	// MARK: Variables
	var myNumber: Float = 0
	var baseCurrency: String!
	var destCurrency: String!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.layer?.backgroundColor = NSColor.whiteColor().CGColor
        // Do view setup here.
		placeholder.hidden = true
		errorLabel.hidden = true
		progressIndicator.hidden = true
		baseCurrencyLabel.stringValue = ""
		baseFlag.stringValue = ""
		baseFlag.hidden = true
		destFlag.hidden = true
		baseFlag.drawsBackground = false
		destFlag.drawsBackground = false
		
		baseNumber.stringValue = ""
		destFlag.stringValue = ""
		destNumber.stringValue = ""
		destCurrencyLabel.stringValue = ""
    }
	
	
	@IBAction func quitBtnClicked(sender: AnyObject) {
		NSApplication.sharedApplication().terminate(self)
	}
	@IBAction func processInput(sender: NSTextField) {
		let res = sender.stringValue
		if ( isCorrect(res) ){
			//outputLabel.stringValue = "You have written the perfect request, fdskfjs fsafsdafjlsdf fsdkflsadkf kdslafkjasd"
			progressIndicator.hidden = false
			progressIndicator.startAnimation(self)
			fetchFirstNumber(res)
		} else {
			print("Oh oh..Me do not understand what write you!")
		}
	}
	
	func resultFetched(rate: Float) {
		progressIndicator.stopAnimation(self)
		progressIndicator.hidden = true
		
		if ( rate == -1 ){
			errorLabel.hidden = true
			hideCurrencySection()
			self.errorLabel.stringValue = "Error: You have typed some currency that's unkown to the system. Correct it and try again !"
			self.errorLabel.hidden = false
		}else {
			self.errorLabel.hidden = true
			unhideCurrencySection()
			let tmpBase = Currencies.getCurrency(self.baseCurrency.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
			let tmpDestination = Currencies.getCurrency(self.destCurrency.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
			baseFlag.stringValue = tmpBase.flag
			baseCurrencyLabel.stringValue = tmpBase.currency.uppercaseString
			baseNumber.stringValue = "\(self.myNumber)"
			destFlag.stringValue = tmpDestination.flag
			destNumber.stringValue = "\(rate)"
			destCurrencyLabel.stringValue = tmpDestination.currency.uppercaseString

		}
		
		
		
	}
	
	// MARK: String parsing
	func isCorrect(input: String) -> Bool {
		if input.rangeOfString("^[C|c]onvert\\s[0-9]+[.]?[0-9]*\\s[a-zA-Z]{3}\\sto\\s[a-zA-Z]{3}", options: .RegularExpressionSearch) != nil {
			//
			return true
		}
			//
		return false
		
	}
	
	func fetchFirstNumber(input: String) {
		
		if let range = input.rangeOfString("^[C|c]onvert", options: .RegularExpressionSearch) {
			let start = range.endIndex.advancedBy(1)
			let trail = input.substringFromIndex(start)
			if let end = trail.rangeOfString("\\s", options: .RegularExpressionSearch) {
				let endFirstNumber = end.endIndex
				let spaceBetween = trail.startIndex.distanceTo(endFirstNumber)
				//print(spaceBetween)
				let finalRange = input.substringWithRange(Range<String.Index>(start..<start.advancedBy(spaceBetween - 1)))
				if let theNumber = Float(finalRange) {
					myNumber = theNumber
					print("number \(myNumber)")
				}
				baseCurrency = trail.substringWithRange(Range<String.Index>(endFirstNumber..<endFirstNumber.advancedBy(4)))
				print(baseCurrency)
				
				destCurrency = trail.substringFromIndex(trail.endIndex.advancedBy(-3))
				print(destCurrency)
				
				let util = NetworkUtils(_base: baseCurrency,number: myNumber,destination: destCurrency, delegate: self)
				util.fetchResult()
			}
		}
		//convert 20 USD to CHF
		//return res
	}
	
	func hideCurrencySection(){
		progressIndicator.hidden = true
		placeholder.hidden = true
		
		destNumber.hidden = true
		baseNumber.hidden = true
		baseFlag.hidden = true
		destFlag.hidden = true
		baseCurrencyLabel.hidden = true
		destCurrencyLabel.hidden = true
		
	}
	
	func unhideCurrencySection(){
		placeholder.hidden = false
		
		destNumber.hidden = false
		baseNumber.hidden = false
		baseFlag.hidden = false
		destFlag.hidden = false
		baseCurrencyLabel.hidden = false
		destCurrencyLabel.hidden = false
		
	}

	
}
