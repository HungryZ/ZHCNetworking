//
//  ZHCNetworking.swift
//  ZHCNetworking
//
//  Created by 张海川 on 2021/4/13.
//

import Alamofire
//import SwiftyJSON

public struct ZHCResponse {
    
    public let data: Any
    
    public var jsonData: [String : Any]? {
        data as? [String: Any]
    }
}

open class ZHCNetworking {
    
    public enum ZHCEncoderType {
        case http
        case json
    }
    
    open private(set) var baseUrl: String!
    
    open private(set) var path: String?
    
    open private(set) var method: HTTPMethod = .post
    
    var parameters: [String: Any]?
    
    open private(set) var encoderType: ZHCEncoderType = .json
    
    open private(set) var headers: HTTPHeaders?
    
    var timeoutInterval: TimeInterval = 60
    
    // todo cache
    
    public init() {}
}

public extension ZHCNetworking {
    
    func request(params: [String : Any]? = nil,
                 succeed: @escaping (ZHCResponse) -> Void,
                 fail: ((AFError) -> Void)? = nil) {
        self.request(params: params).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let result):
                succeed(ZHCResponse(data: result))
                
            case .failure(let error):
                if let failAction = fail {
                    failAction(error)
                }
            }
        })
    }
    
    private func request(params: [String : Any]?) -> DataRequest {
        let urlString = baseUrl + (path ?? "")
        let reqParams = params != nil ? params : parameters
        
        if encoderType == .http {
            return AF.request(urlString,
                              method: method,
                              parameters: reqParams,
                              headers: headers,
                              requestModifier: { (urlRequest) in
                                urlRequest.timeoutInterval = self.timeoutInterval
                              })
        } else {
            let httpBody: Data?
            if let parameters = reqParams {
                if JSONSerialization.isValidJSONObject(parameters) {
                    httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                } else {
                    fatalError("params is NOT encodable")
                }
            } else {
                httpBody = nil
            }
            return AF.request(urlString,
                              method: method,
                              headers: headers,
                              requestModifier: { (urlRequest) in
                                urlRequest.timeoutInterval = self.timeoutInterval
                                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                urlRequest.httpBody = httpBody
                              })
        }
    }
}
