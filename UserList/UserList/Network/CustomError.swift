//
//  CustomError.swift
//  UserList
//
//  Created by Hüsnü Taş on 28.01.2024.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidData
    case other(Error)
}
