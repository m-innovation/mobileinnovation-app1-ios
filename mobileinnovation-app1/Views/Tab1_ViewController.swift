//
//  Tab1_ViewController.swift
//  mobileinnovation-app1
//
//  Created by M.Amatani on 2017/08/17.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

import UIKit

class Tab1_ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.base_setStatusBarBackgroundColor(color: #colorLiteral(red: 0.4117647059, green: 0.8039215686, blue: 0.7921568627, alpha: 1))

        //self.base_tabIconCountSet(tabNo: 1, bage:"123")


        //        lbl_token.text = config_instance.configurationGet_String(keyName: "DeviceToken")

        //        let queryItems = [URLQueryItem(name: "a", value: "foo"),
        //                          URLQueryItem(name: "b", value: "1234")]
        //        urlSessionGetClient.get(currentView: self, url: "http://192.168.0.170:8000/api/json_notice_list/", queryItems: nil, session: urlSessionGetClient)


        //        lbl_token.text = config_instance.configurationGet_String(keyName: "DeviceToken")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
