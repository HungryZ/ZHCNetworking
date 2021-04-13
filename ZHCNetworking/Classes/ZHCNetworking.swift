//
//  ZHCNetworking.swift
//  LoginSDK
//
//  Created by 张海川 on 2021/4/13.
//

import Alamofire

public struct ZHCResponse {
    let data: Any
    let jsonData: [String : Any]?
}

open class ZHCNetworking {
    
    public enum ZHCEncoderType {
        case http
        case json
    }
    
    open private(set) var baseUrl: String!
    
    open private(set) var path: String!
    
    open private(set) var method: HTTPMethod = .post
    
    var parameters: [String: Any]?
    
    open private(set) var encoderType: ZHCEncoderType = .json
    
    open private(set) var headers: HTTPHeaders?
    
    var showLoading = true
    
    var HUD: UIView?
    
    var timeoutInterval: TimeInterval = 60
    
    // todo cache
    
    public init() {
        
    }
}

/// chain syntax
public extension ZHCNetworking {
    
    func setParameters(_ params: [String: Any]?) -> ZHCNetworking {
        parameters = params
        return self
    }
    
    func setHUD(_ hud: UIView?) -> ZHCNetworking {
        HUD = hud
        return self
    }
    
    func request(params: [String : Any]? = nil, succeed: @escaping (ZHCResponse) -> Void, fail: ((AFError) -> Void)? = nil) {
        let urlString = baseUrl + path
        let reqParams = (params != nil ? params : parameters) as! [String : [[String : String]]]
//        let reqParams = params != nil ? params : parameters
        let encoder: ParameterEncoder = encoderType == .http ? URLEncodedFormParameterEncoder.default : JSONParameterEncoder.default
        
        AF.request(urlString, method: method, parameters: reqParams, encoder: encoder, headers: headers, requestModifier: { (urlRequest) in
            urlRequest.timeoutInterval = self.timeoutInterval

        }).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let result):
                succeed(ZHCResponse(data: result, jsonData: result as? [String: Any]))
                
            case .failure(let error):
                if let failAction = fail {
                    failAction(error)
                }
            }
        })
    }
}
