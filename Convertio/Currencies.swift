//
//  Currencies.swift
//  Convertio
//
//  Created by sahbi.alhajbel on 26.05.16.
//  Copyright © 2016 sahbi.alhajbel. All rights reserved.
//

import Foundation

struct Currencies {
	private static let countries : [(name: String,currency: String, flag: String)] = [
		(name: "Europe",currency: "EUR", flag: "🇪🇺"),
		(name: "Switzerland",currency: "CHF", flag: "🇨🇭"),
		(name: "USA",currency: "USD", flag: "🇺🇸"),
		(name: "Europe",currency: "GBP", flag: "🇬🇧"),
		(name: "Europe",currency: "SEK", flag: "🇸🇪"),
		(name: "Europe",currency: "TND", flag: "🇹🇳"),
		(name: "Europe",currency: "SAR", flag: "🇸🇦"),
		(name: "Europe",currency: "SGD", flag: "🇸🇬"),
		(name: "Europe",currency: "RUB", flag: "🇷🇺"),
		(name: "Europe",currency: "QAR", flag: "🇶🇦"),
		(name: "Europe",currency: "OMR", flag: "🇴🇲"),
		(name: "Europe",currency: "NGN", flag: "🇳🇬"),
		(name: "Europe",currency: "MYR", flag: "🇲🇾"),
		(name: "Europe",currency: "MXN", flag: "🇲🇽"),
		(name: "Europe",currency: "MAD", flag: "🇲🇦"),
		(name: "Europe",currency: "JPY", flag: "🇯🇵"),
		(name: "Europe",currency: "ISK", flag: "🇮🇸"),
		(name: "Europe",currency: "EGP", flag: "🇪🇬"),
		(name: "Europe",currency: "DKK", flag: "🇩🇰"),
		(name: "Europe",currency: "CZK", flag: "🇨🇿"),
		(name: "Europe",currency: "CNY", flag: "🇨🇳"),
		(name: "Europe",currency: "AUD", flag: "🇦🇺"),
		(name: "Europe",currency: "ARS", flag: "🇦🇷"),
		(name: "Europe",currency: "ALL", flag: "🇦🇱"),
		(name: "Europe",currency: "AED", flag: "🇦🇪"),
		(name: "Europe",currency: "BHD", flag: "🇧🇭"),
		(name: "Europe",currency: "BGN", flag: "🇧🇬"),
		(name: "Europe",currency: "AZN", flag: "🇦🇿"),
		(name: "Europe",currency: "BRL", flag: "🇧🇷"),
		(name: "Europe",currency: "BTC", flag: "💰"),
	]
	
	static func getCurrency(name: String) -> (name: String, currency: String, flag: String) {
		for country in countries {
			if ( country.currency == name.uppercaseString) {
				return country
			}
		}
		return (name: "Unknown", currency: "NONE", flag: "❌")
	}
	
	
}