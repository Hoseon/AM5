//
//  ResultState.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/01/31.
//

import Foundation

enum ResultState {
    case loading
    case success
    case failed(error: Error)
}
