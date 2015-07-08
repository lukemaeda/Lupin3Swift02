//
//  ViewController.swift
//  Lupin3Swift02
//
//  Created by MAEDAHAJIME on 2015/07/09.
//  Copyright (c) 2015年 MAEDA HAJIME. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    // Outlet設定
    @IBOutlet weak var lbTitle: UILabel!
    
    // タイトル
    let titleStr = "ルパン三世"
    
    // 表示文字インデックス
    var idx = 0
    
    // 効果音
    var ssId01: SystemSoundID = 0
    var ssId02: SystemSoundID = 0
    
    // 画面ロード時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 効果音の設定
        // （効果音１）
        var bnd = NSBundle.mainBundle()
        var url01 = bnd.URLForResource("Sound01", withExtension: "wav")
        AudioServicesCreateSystemSoundID(url01 as! CFURLRef, &ssId01)
        // （効果音２）
        var url02 = bnd.URLForResource("Sound02", withExtension: "wav")
        AudioServicesCreateSystemSoundID(url02 as! CFURLRef, &ssId02)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 画面タッチ開始
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // インデックス初期化
        idx = 0
        
        // タイマー起動
        var tmr = NSTimer.scheduledTimerWithTimeInterval(
            0.2,
            target: self,
            selector: Selector("tickTimer:"),
            userInfo: nil,
            repeats: true)
        tmr.fire()
    }
    
    // タイマー処理
    func tickTimer(timer: NSTimer) {
        
        // タイトルのインデックス判定（1文字表示／全文字表示）
        if idx < count(titleStr) {
            
            // 効果音再生
            AudioServicesPlaySystemSound(ssId01)
            
            // テキストフォント設定
            lbTitle.font = UIFont.systemFontOfSize(280.0)
            
            // 対象文字の表示
            var loc = advance(titleStr.startIndex, idx)
            lbTitle.text = String(titleStr[loc])
            
            // インデックス値インクリメント
            idx++;
            
        } else {
            
            // 効果音再生
            AudioServicesPlaySystemSound(ssId02)
            
            // テキストフォント設定
            lbTitle.font = UIFont.systemFontOfSize(100.0)
            
            // 全文字列の表示
            lbTitle.text = titleStr;
            
            // タイマー停止
            timer.invalidate()
        }
    }
}

