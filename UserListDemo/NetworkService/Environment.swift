//
//  Environment.swift
//  UserListDemo
//
//  Created by Bishal Ram on 26/04/24.
//

import Foundation

enum Environment {
    case test
}

extension Environment {
    var baseURL: String {
        switch self {
        case .test:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
}
