//
//  Date + Extension.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import UIKit

extension Date {
    func dateString(withFormat format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
