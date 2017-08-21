//
//  Tab3_ViewController.swift
//  mobileinnovation-app1
//
//  Created by M.Amatani on 2017/08/17.
//  Copyright © 2017年 Mobile Innovation. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tab3_ViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    // UrlSession_libのインスタンス(apikeyget用)
    let urlSessionGetClient_jsonNoticeList = UrlSession_lib()

    var json_Data: JSON = []

    @IBOutlet weak var notice_boardTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        notice_boardTableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.base_setStatusBarBackgroundColor(color: #colorLiteral(red: 0.2549019608, green: 0.3490196078, blue: 0.5411764706, alpha: 1))

        // APIKEY取得
        urlSessionGetClient_jsonNoticeList.get(urlSession_lib: urlSessionGetClient_jsonNoticeList, currentView: self, url: "/api/json_notice_list/")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json_Data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }

    // UrlSession_lib processing
    override func UrlSessionBack_SuccessAction(urlSession_lib: UrlSession_lib, currentView: BaseViewController, json: JSON) {

        if urlSession_lib == urlSessionGetClient_jsonNoticeList {

            json_Data = json["notices"]
            notice_boardTableview.reloadData()
        }
    }
    override func UrlSessionBack_DataFailureAction(urlSession_lib: UrlSession_lib, statusErrCode: Int, errType: String) {

        if urlSession_lib == urlSessionGetClient_jsonNoticeList {

            let alert = UIAlertController(
                title: "エラー",
                message: "通信に失敗しました。電波条件の良い場所で再度お試しください。(エラーコード：\(statusErrCode))",
                preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
    override func UrlSessionBack_HttpFailureAction(errType: String) {

        let alert = UIAlertController(
            title: "エラー",
            message: "通信に失敗しました。電波条件の良い場所で再度お試しください。",
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
