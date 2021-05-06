//
//  UserModel.swift
//  AkvelonTest
//
//  Created by Danijel Vasov on 6.5.21..
//

import Foundation
import SwiftUI

struct User: Codable, Hashable {
    let id: String
    let wasOnline: String
    let firstName: String
    let avatar: String
    let lastName: String
}

