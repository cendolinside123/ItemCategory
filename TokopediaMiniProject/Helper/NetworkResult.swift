//
//  NetworkResult.swift
//  TokopediaMiniProject
//
//  Created by Mac on 14/01/22.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failed(Error)
}

enum NetworkError: Error {
    case loadFailed
}
