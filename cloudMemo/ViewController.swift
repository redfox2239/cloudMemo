//
//  ViewController.swift
//  cloudMemo
//
//  Created by REO HARADA on 2018/11/03.
//  Copyright © 2018年 REO HARADA. All rights reserved.
//

import UIKit

// tableViewと相談する準備その１
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var memoListTableView: UITableView!
    
    // メモデータ
    var memoData: [String] = []
    
    // 画面読み込んだときどうするぅ？
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // tableViewと相談する準備その２
        self.memoListTableView.delegate = self
        self.memoListTableView.dataSource = self
        
        // niftyのmbaasを利用するための鍵を設定する
        NCMB.setApplicationKey("fb2e810af40e559d06478eea30924a2523293dd4a42bc61c70fad96e1b14e118", clientKey: "105886742ada1f577b54f5f25ca7664569b8f348bac6cfded691842072eacfed")

    }
    
    // 画面が表示される瞬間どうするぅ？
    override func viewWillAppear(_ animated: Bool) {
//        // データを取得してくれる人を呼んでくる
//        let getDefaults = UserDefaults.standard
//        // "memo"にデータが存在しなければ終了
//        if getDefaults.object(forKey: "memo") == nil {
//            // すぐに終了
//            return
//        }
//        // "memo"に保存されてるデータを取得する
//        self.memoData = getDefaults.object(forKey: "memo") as! [String]
//        // tableViewと相談し直す
//        self.memoListTableView.reloadData()
        
        // niftyのmbaasからデータを取得する
        NCMB.setApplicationKey("fb2e810af40e559d06478eea30924a2523293dd4a42bc61c70fad96e1b14e118", clientKey: "105886742ada1f577b54f5f25ca7664569b8f348bac6cfded691842072eacfed")
        // niftyのmbaasからデータを取得してくれる人を呼んでくる
        let getNCMB = NCMBQuery(className: "memo")
        // "writer"は"はらだれお"のデータに絞る
        getNCMB?.whereKey("writer", equalTo: "はらだれお")
        // 通信してデータを取得する
        let savedData = try! getNCMB?.findObjects() as! [NCMBObject]
        // memoDataの配列を一度空にする（画面が戻ってきたときの対応）
        self.memoData = []
        // データをfor文でひとつずつ見る
        for obj in savedData {
            print(obj)
            // "content"に格納されてるデータを取り出す
            let obj = obj.object(forKey: "content") as! String
            // "content"に格納されてるデータをmemoDataの配列に追加していく
            self.memoData.append(obj)
        }
        // tableViewと相談し直す
        self.memoListTableView.reloadData()
    }
    
    // ↓tableViewとの相談
    
    // セクションの数どうするぅ？
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セルの数どうするぅ？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memoData.count
    }
    
    // 各行のセルの中身どうするぅ？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // memoListTableViewの中の白い"cell"というセルをください
        let cell = self.memoListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.memoData[indexPath.row]
        return cell
    }
    
    // 各行のセルを編集するときどうするぅ？
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 配列からデータを削除する
        self.memoData.remove(at: indexPath.row)
//        // データを保存してくれる人を読んでくる
//        let saveDefaults = UserDefaults.standard
//        // "memo"に保存されてるデータを取得する
//        var savedData = saveDefaults.object(forKey: "memo") as! [String]
//        // 保存されていたデータから対象データを削除する
//        savedData.remove(at: indexPath.row)
//        // saveDefaultsにデータを渡す
//        saveDefaults.set(savedData, forKey: "memo")
//        // いますぐ保存してね
//        saveDefaults.synchronize()
        
        // niftyのmbaasからデータを削除する
        // niftyのmbaasにデータを取得する人を呼んでくる
        let getNCMB = NCMBQuery(className: "memo")
        // "writer"は"はらだれお"のデータに絞る
        getNCMB?.whereKey("writer", equalTo: "はらだれお")
        // 通信してデータを取得する
        let savedData = try! getNCMB?.findObjects() as! [NCMBObject]
        // 削除したいデータを指定して削除する
        savedData[indexPath.row].delete(nil)
        
        // tableViewと相談し直す
        self.memoListTableView.reloadData()
    }
    
    // ↑tableViewとの相談

}

