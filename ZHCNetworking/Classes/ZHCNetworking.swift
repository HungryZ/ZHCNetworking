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
    
    open private(set) var baseUrl: String!
    
    open private(set) var path: String!
    
    open private(set) var method: HTTPMethod = .post
    
    var parameters: [String: Any]?
    
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
        let reqParams = params != nil ? params : parameters
        
        let dic: [String : Any] = [
            "clickCount" : 0,
            "communityUuid" : 1557133592437760,
            "exposureCount" : 21,
            "uploadTime" : "2021-04-13 17:43:37",
            "userUuid" : 1575275730330624,
            "uuid" : 132340357397902,
        ]
        let array = [dic]
        let param = ["log" : array]
        let jsonData = try! JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
        
        AF.request(urlString, method: method, parameters: jsonData, headers: headers, requestModifier: { (urlRequest) in
            urlRequest.timeoutInterval = self.timeoutInterval
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("91c405ef-8e38-47ac-8c73-abecb0c363a6", forHTTPHeaderField: "token")
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
