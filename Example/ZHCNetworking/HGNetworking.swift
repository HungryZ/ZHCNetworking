//
//  HGNetworking.swift
//  ZHCNetworking_Example
//
//  Created by 张海川 on 2021/4/13.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Alamofire
import ZHCNetworking

class HGNetworking: ZHCNetworking {

    override var baseUrl: String! {
        "https://hxq.komect.com"
    }
    
//    override var headers: HTTPHeaders? {
//        ["Content-Type" : "application/json"]
//    }
}
