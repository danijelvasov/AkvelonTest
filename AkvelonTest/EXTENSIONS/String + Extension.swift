//
//  String + Extension.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import UIKit

extension String {
    func formatDateFromServerString() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = DateConstants.SERVER_LONG_TIME_FORMAT.rawValue
        return formatter.date(from: self)
    }
}
