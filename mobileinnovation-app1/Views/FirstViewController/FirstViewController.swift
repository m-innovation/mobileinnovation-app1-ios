//
//  FirstViewController.swift
//  mobileinnovation-app1
//
//  Created by M.Amatani on 2017/08/15.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

import UIKit
import LTMorphingLabel
import SwiftyJSON

class FirstViewController: BaseViewController {

    // UrlSession_libのインスタンス(apikeyget用)
    let urlSessionGetClient_apikeyget = UrlSession_lib()
    // UrlSession_libのインスタンス(apidevicetoken用)
    let urlSessionGetClient_apidevicetoken = UrlSession_lib()

    // Loading関連変数
    @IBOutlet weak var lbl_Loading: LTMorphingLabel!
    var timer_loading: Timer!
    var int_count_paternNo_loading: Int!
    var patern_loading:[String]!

    @IBOutlet weak var img_logo: UIImageView!
    @IBOutlet weak var lbl_info1: UILabel!
    @IBOutlet weak var lbl_info2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // 下のローディング文字
        lbl_Loading.morphingEffect = .sparkle
        int_count_paternNo_loading = 0
        patern_loading = ["L", "Lo", "Loa", "Load", "Loadi", "Loadin", "Loading", "Loading ", "Loading N", "Loading No", "Loading Now"]

        timer_loading = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer_loading.fire()

        // DeviceToken 初期化
        self.base_config_instance.configurationSet_String(value: "", keyName: "DeviceToken")
        #if (!arch(i386) && !arch(x86_64))
            // 実機

            // 起動ごとにDeviceToken取得
            self.base_appDelegate.setNotification()
        #else
            // シミュレータ時の仮DeviceToken設定
            self.base_config_instance.configurationSet_String(value: "ios_Emureter999999999999999999999999999999999999999999999999999999999999999", keyName: "DeviceToken")
        #endif

        // logoフェードイン
        lbl_info1.fadeIn(type: .Slow)
        lbl_info2.fadeIn(type: .Slow)
        lbl_info1.fadeIn(type: .Slow) { [weak self] in

            //APIKEY取得
            self?.getApi_akikey()
        }
    }

    func update(tm: Timer) {
        lbl_Loading.text = patern_loading[int_count_paternNo_loading]
        int_count_paternNo_loading = int_count_paternNo_loading + 1
        if patern_loading.count <= int_count_paternNo_loading {
            int_count_paternNo_loading = 0
        }
    }

    func getApi_akikey() {

        // 本体のAPP_CODE取得
        let path = Bundle.main.path(forResource: "propaty", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        let appCode: AnyObject = dictionary?.object(forKey: "APP_CODE") as AnyObject

        // POST
        let urlString: String = HttpRequestController().getDomain() + "/api/apikey_get"
        let post: String = "app_code=" + (appCode as! String)
        let parsedData: JSON = HttpRequestController().sendPostRequestSynchronous(urlString: urlString, post: post)
        print(parsedData)

        // ApiKey ローカル保存
        let dic = parsedData["apikey"].string
        self.base_config_instance.configurationSet_String(value: dic!, keyName: "ApiKey")
        print("apikey = " + self.base_config_instance.configurationGet_String(keyName: "ApiKey"))

        // DeviceTokenチェック
        while true {
            if self.base_config_instance.configurationGet_String(keyName: "DeviceToken") != "" {
                break
            }
        }

        // DeviceToken登録
        self.setApi_devicetoken()
    }

    func setApi_devicetoken() {

        // 本体のAPP_CODE取得
        let path = Bundle.main.path(forResource: "propaty", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        let appCode: AnyObject = dictionary?.object(forKey: "APP_CODE") as AnyObject

        // POST
        let urlString: String = HttpRequestController().getDomain() + "/api/notification/token_post"
        #if DEBUG
            // APIKEY取得
            let post: String = "app_code=" + (appCode as! String) + "&device_token=" + self.base_config_instance.configurationGet_String(keyName: "DeviceToken") + "&device_type=" + "iOS_Staging"
        #else
            // APIKEY取得
            let post: String = "app_code=" + (appCode as! String) + "&device_token=" + self.base_config_instance.configurationGet_String(keyName: "DeviceToken") + "&device_type=" + "iOS"
        #endif
        let parsedData: JSON = HttpRequestController().sendPostRequestSynchronous(urlString: urlString, post: post)
        print(parsedData)

        // タイマーストップ
        timer_loading.invalidate()

        // 画面遷移
        let next = storyboard!.instantiateViewController(withIdentifier: "MainNavigation")
        self.present(next,animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
