//
//  ViewController.swift
//  ZHCNetworking
//
//  Created by zhanghaichuan on 04/13/2021.
//  Copyright (c) 2021 zhanghaichuan. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: Any) {
//        let dic = [
//            "clickCount" : 0,
//            "communityUuid" : "1557133592437760",
//            "exposureCount" : "21",
//            "uploadTime" : "Date()",
//            "userUuid" : "1575275730330624",
//            "uuid" : 132340357397902,
//        ] as [String : Any]
//        let array = [dic]
//        let param = ["log" : array]
//
//        HGTrackAPI().request(params: param) { (response) in
//            print(response.jsonData!)
//        } fail: { (error) in
//            print(error)
//        }
        MoyaProvider().request(MyService.zen) { (result) in
            
        }
        
        let provider = MoyaProvider<MyService>()
        provider.request(.zen) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
//                let statusCode = moyaResponse.statusCode
                let json = JSON(data)
                print(json)
                // do something with the response data or statusCode
            case let .failure(error): break
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
}

enum MyService {
    case zen
}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { return URL(string: "https://httpbin.org/post")! }
    var path: String {
        switch self {
        case .zen:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .zen:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .zen:
            return .requestParameters(parameters: ["first_name": "firstName", "last_name": "lastName"], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .zen:
            return try! JSON(["keyyy" : "valueeee"]).rawData()
        }
    }
    var headers: [String: String]? {
        return [:]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
