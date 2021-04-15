//
//  HGTrackAPI.swift
//  ZHCNetworking_Example
//
//  Created by 张海川 on 2021/4/13.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ZHCNetworking

class HGTrackAPI: HGNetworking {
    
    override var baseUrl: String! {
        "https://httpbin.org/post"
    }

    override var path: String! {
        ""
    }
    
    override var encoderType: ZHCNetworking.ZHCEncoderType {
        .json
    }
}
