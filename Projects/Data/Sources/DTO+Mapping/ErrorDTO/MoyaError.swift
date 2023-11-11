//
//  MoyaError.swift
//  Data
//
//  Created by Lee Myeonghwan on 2023/07/07.
//  Copyright © 2023 com.lito. All rights reserved.
//

import Foundation
import Moya
import Domain

extension MoyaError {
    
    /*
     /// Response의 data를 이미지로 맵핑하는 과정에서 발생할 수 있는 에러
     case imageMapping(Response)
     
     /// Response의 data를 json 으로 맵핑하는 과정에서 발생할 수 있는 에러
     case jsonMapping(Response)
     
     /// Response의 data를 string 으로 맵핑하는 과정에서 발생할 수 있는 에러
     case stringMapping(Response)
     
     /// Response의 data를 특정 타입으로 파싱하는 과정에서 발생할 수 있는 에러
     case objectMapping(Swift.Error, Response)
     
     /// URLRequest를 만들때 httpBody 를 인코딩하는 과정에서 발생할 수 있는 에러
     case encodableMapping(Swift.Error)
     
     /// Response 의 statusCode가 설정한 statusCode에 포함되지 않는다면 발생하는 에러
     case statusCode(Response)
     
     /// URLRequest 요청, 수행과정에서 발생할 수 있는 에러
     case underlying(Swift.Error, Response?)
     
     /// URLRequest를 만들때 String 을 URL로 변환하는 과정에서 발생할 수 있는 에러
     case requestMapping(String)
     
     /// URLRequest를 만들때 parameter 를 인코딩하는 과정에서 발생할 수 있는 에러
     case parameterEncoding(Swift.Error)
     */
    
    public func toVO() -> ErrorVO {
        switch self {
        case .underlying(_, let response):
            if let response = response {
                if response.statusCode == 500 {
                    return .retryableError("일시적인 서버 에러입니다. 잠시 후 다시 시도해주세요.")
                }
            }
            return .fatalError
        default:
            return .fatalError
        }
    }
    
    public var debugString: String {
        switch self {
        case .imageMapping(let response):
            return makeDebugString(title: "imageMapping", response: response, dataParse: false)
        case .jsonMapping(let response):
            return makeDebugString(title: "jsonMapping", response: response, dataParse: true)
        case .stringMapping(let response):
            return makeDebugString(title: "stringMapping", response: response)
        case .objectMapping(let error, let response):
            return makeDebugString(title: "objectMapping", response: response, error: error)
        case .encodableMapping(let error):
            return makeDebugString(title: "encodableMapping", error: error)
        case .statusCode(let response):
            return makeDebugString(title: "statusCode", response: response)
        case .underlying(let error, let response):
            return makeDebugString(title: "underlying", response: response, error: error)
        case .requestMapping(let urlString):
            return makeDebugString(title: "requestMapping") + "urlString: \(urlString)"
        case .parameterEncoding(let error):
            return makeDebugString(title: "parameterEncoding", error: error)
        }
    }
    
    private func makeDebugString(title: String, response: Response? = nil, error: Error? = nil, dataParse: Bool = true) -> String {
        var debugDescription: String = "Empty"
        var errorLocalizedDescription: String = "Empty"
        var parsedData = "Empty"
        if let response = response {
            debugDescription = response.debugDescription
            if dataParse {
                parsedData = String(data: response.data, encoding: .utf8) ?? "Empty"
            }
        }
        if let error = error {
            errorLocalizedDescription = error.localizedDescription
        }
        return """
        ⛑️ Moya \(title) Error
        statusCode: \(response?.statusCode ?? 0)
        debugDescription: \(debugDescription)
        errorDescription: \(errorLocalizedDescription)
        parsedData: \(parsedData)
        """
    }
    
}
