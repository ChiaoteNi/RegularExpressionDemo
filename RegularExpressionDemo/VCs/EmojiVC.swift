//
//  ViewController.swift
//  Attr_Range_RegularExpTest
//
//  Created by admin on 2019/4/5.
//  Copyright © 2019 aaronni. All rights reserved.
//

import UIKit

class EmojiVC: BaseVC {
    
    @IBOutlet private weak var txtLB: UILabel!
    @IBOutlet private weak var emojiLB: UILabel!
    
    private let txt = "[葡萄]fefjewifwoi[哈哈]eof;'[いい味]f||gw[乒乓][鼓掌][章魚][不認同]g jkwofgfwes;fkmewddlf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newTxt = txt.convertAttrStrToEmoji(fontSize: 24) {
            print(newTxt)
            emojiLB.attributedText = newTxt
        } else {
            emojiLB.text = txt
        }
        
        txtLB.text = txt
        txtLB.font = UIFont.systemFont(ofSize: 24)
    }
}
