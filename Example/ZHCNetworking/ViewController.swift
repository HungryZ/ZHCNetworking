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
        let dic = [
            "clickCount" : 0,
            "communityUuid" : "1557133592437760",
            "exposureCount" : "21",
            "uploadTime" : "Date()",
            "userUuid" : "1575275730330624",
            "uuid" : 132340357397902,
        ] as [String : Any]
        let array = [dic]
        let param = ["log" : array]
        
        HGTrackAPI().request(params: param) { (response) in
            print(response.jsonData!)
        } fail: { (error) in
            print(error)
        }
    }
}
