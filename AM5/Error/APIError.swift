//
//  APIError.swift
//  AM5
//
//  Created by HoSeon Chu on 2023/01/31.
//

import Foundation

enum APIError: Error {
    case decodingError // 디코딩 에러
    case errorCode(Int) // HttpStatus에러들받을때
    case unknown // 알수 없는 에러 일때
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "서비스로 부터 받아온 오브젝트가 디코딩에 실패 했습니다"
        case .errorCode(let code):
            return "\(code) - API상태 에러 발생"
        case .unknown:
            return "알수 없는 에러 발생"
        }
    }
}
