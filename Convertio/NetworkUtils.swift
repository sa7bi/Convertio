//
//  NetworkUtils.swift
//  Convertio
//
//  Created by sahbi.alhajbel on 24.05.16.
//  Copyright © 2016 sahbi.alhajbel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkUtils: NSObject {
	//var baseUrl: String = "https://api.fixer.io/latest"
	var baseUrl : String = "https://www.google.com/finance/converter"
	var base: String!
	var number: Float!
	var destination: String!
	var delegate: CurrencyDelegate
	
	init(_base base : String, number: Float, destination: String, delegate: CurrencyDelegate) {
		self.base = base.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.destination = destination.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.baseUrl += "?a=\(number)"
		self.baseUrl += "&from=\(self.base.uppercaseString)"
		self.baseUrl += "&to=\(self.destination.uppercaseString)"
//		self.baseUrl += "?base=\(self.base.uppercaseString)"
//		self.baseUrl += "&symbols=\(self.destination.uppercaseString)"
		self.delegate = delegate
		print("NetworkUtils: \(self.baseUrl)")
	}
	
	func fetchResult(){
		
		Alamofire.request(.GET, self.baseUrl)
			//.validate(statusCode: 200..<300)
			//.validate(contentType: ["application/json"])
			.validate(contentType: ["text/html"])
			.responseString { response in
				let result = response.result.value
				let myRegex = "<span class=bld>(.+?)</span>"
				if self.matchesForRegexInText(myRegex, text: result)[0] != "empty" {
					let finalResponse = self.matchesForRegexInText(myRegex, text: result)[0]
					if let rate = finalResponse.rangeOfString("^<span class=bld>", options: .RegularExpressionSearch) {
						let destPosition = finalResponse.rangeOfString("[A-Z]{3}</span", options: .RegularExpressionSearch)
						let content = finalResponse.substringWithRange(Range<String.Index>(rate.endIndex..<destPosition!.startIndex)).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
						self.delegate.resultFetched(Float(content)!)
					}
				}
				else {
					self.delegate.resultFetched(-1)
				}
		}
		
		
	}
	
	func matchesForRegexInText(regex: String!, text: String!) -> [String] {
		
		do {
			let regex = try NSRegularExpression(pattern: regex, options: [])
			let nsString = text as NSString
			if !regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length)).indices.isEmpty{
				let results = regex.matchesInString(text, options: [], range: NSMakeRange(0, nsString.length))
				return results.map { nsString.substringWithRange($0.range)}
			} else {
				return ["empty"]
			}
			
		} catch let error as NSError {
			print("invalid regex: \(error.localizedDescription)")
			return ["empty"]
		}
	}
	
//	func processJSON(data: NSData) -> Float {
//		//var res : String!
//		let json = JSON(data: data)
//		print(json)
//		let rate = json["rates"]["CHF"].floatValue
//		print(rate)
//		return rate
//		
//	}
}