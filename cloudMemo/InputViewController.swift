//
//  InputViewController.swift
//  cloudMemo
//
//  Created by REO HARADA on 2018/11/17.
//  Copyright © 2018年 REO HARADA. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var inputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapCompleteButton(_ sender: Any) {
        // inputTextViewの内容を取得
        let inputMemo = self.inputTextView.text
//        // データを保存してくれる人を呼んでくる
//        let saveDefaults = UserDefaults.standard
//        // まだ、"memo"のUserDefaultsにデータが保存されない場合
//        if saveDefaults.object(forKey: "memo") == nil {
//            // saveDefaultsに配列の形でデータを渡す
//            saveDefaults.set([inputMemo], forKey: "memo")
//        }
//        // すでに"memo"のUserDefaultsにデータが保存されてる場合
//        else {
//            // "memo"に保存されてるデータを取得する
//            var savedMemo = saveDefaults.object(forKey: "memo") as! [String]
//            // すでに保存されいてたデータにinputMemoを追加する
//            savedMemo.append(inputMemo!)
//            // saveDefaultsにデータを渡す
//            saveDefaults.set(savedMemo, forKey: "memo")
//        }
//        // いますぐ保存してね
//        saveDefaults.synchronize()
        
        // niftyのmbaasにデータを保存する
        // niftyのmbaasにデータを保存してくれる人を呼んでくる
        let saveNCMB = NCMBObject(className: "memo")
        // 保存したいデータを渡す
        saveNCMB?.setObject(inputMemo, forKey: "content")
        saveNCMB?.setObject("はらだれお", forKey: "writer")
        // 通信してデータを保存する
        saveNCMB?.save(nil)
        // 一つ前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
}
