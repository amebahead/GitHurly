//
//  Int+Extensions.swift
//  GitHurly
//
//  Created by MacDole on 2022/03/31.
//

import Foundation

extension Int {
    func formatCurrency(showCurrencySymbol: Bool = false) -> String? {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        if(showCurrencySymbol == false) {
            formatter.currencySymbol = ""
        }
        
        return formatter.string(from: NSNumber(value: self))
    }
}
