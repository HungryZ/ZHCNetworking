//
//  ViewController.swift
//  ZHCNetworking
//
//  Created by zhanghaichuan on 04/13/2021.
//  Copyright (c) 2021 zhanghaichuan. All rights reserved.
//

import UIKit

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
        HGTrackAPI().request(params: param) { (response) in
            print(response)
        } fail: { (error) in
            print(error)
        }

    }
}

/**
 {
     log =     (
                 {
             clickCount = 0;
             communityUuid = 1557133592437760;
             exposureCount = 21;
             uploadTime = "2021-04-13 17:43:37";
             userUuid = 1575275730330624;
             uuid = 132340357397902;
         },
                 {
             clickCount = 5;
             communityUuid = 1557133592437760;
             exposureCount = 0;
             uploadTime = "2021-04-13 17:43:50";
             userUuid = 1575275730330624;
             uuid = 1;
         },
                 {
             clickCount = 0;
             communityUuid = 1557133592437760;
             exposureCount = 21;
             uploadTime = "2021-04-13 17:43:37";
             userUuid = 1575275730330624;
             uuid = 132340357397900;
         },
                 {
             clickCount = 2;
             communityUuid = 1443196120597504;
             exposureCount = 43;
             uploadTime = "2021-04-13 17:44:08";
             userUuid = 1454671390835712;
             uuid = 1416886342427648;
         },
                 {
             clickCount = 0;
             communityUuid = 1557133592437760;
             exposureCount = 21;
             uploadTime = "2021-04-13 17:43:37";
             userUuid = 1575275730330624;
             uuid = 132340357397901;
         }
     );
 }
 */
