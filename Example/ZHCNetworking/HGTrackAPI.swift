//
//  HGTrackAPI.swift
//  ZHCNetworking_Example
//
//  Created by 张海川 on 2021/4/13.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import ZHCNetworking

class HGTrackAPI: HGNetworking {

    override var path: String! {
        "/openAuth/adv/log/upload"
    }
    
    override var encoderType: ZHCNetworking.ZHCEncoderType {
        .json
    }
}
