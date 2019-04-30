//
//  URLFormatterVC.swift
//  Attr_Range_RegularExpTest
//
//  Created by admin on 2019/4/9.
//  Copyright © 2019 aaronni. All rights reserved.
//

import UIKit

class URLFormatterVC: BaseVC {

    @IBOutlet private weak var txtLabel: UILabel!
    @IBOutlet private weak var txtView: UITextView!
    
    private var txt: String = "哈哈哈 https://hihi.com我有中文唷"
    private var pattern: String = "\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLabel.text = txt
        txtLabel.font = UIFont.systemFont(ofSize: 24)
        
        txtView.isSelectable = true
        txtView.isUserInteractionEnabled = true
        
        guard let attrStr = formatUrl(with: txt, pattern: pattern) else { return }
        txtView.attributedText = attrStr
    }
    
    private func formatUrl(with txt: String, pattern: String) -> NSAttributedString? {
        let ranges = txt.getMatchedRanges(for: pattern)
        let attrStr = NSMutableAttributedString.init(string: txt)
        for range in ranges {
            let txt = (txt as NSString).substring(with: range)
            guard let url = URL.init(string: txt) else { continue }
            attrStr.addAttribute(.link, value: url, range: range)
        }
        attrStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange.init(location: 0, length: txt.count))
        return attrStr
    }
}

/*
 特別字符    描述
 
 ( )    標記一個子表達式的開始和結束位置。子表達式可以獲取供以後使用。要匹配這些字符，請使用\( 和\)。
 *    匹配前面的子表達式零次或多次。要匹配* 字符，請使用\*。
 +    匹配前面的子表達式一次或多次。要匹配+ 字符，請使用\+。
 .    匹配除換行符\n 之外的任何單字符。要匹配. ，請使用\. 。
 [    標記一個中括號表達式的開始。要匹配[，請使用\[。
 ?    匹配前面的子表達式零次或一次，或指明一個非貪婪限定符。要匹配? 字符，請使用\?。
 \    將下一個字符標記為或特殊字符、或原義字符、或向後引用、或八進制轉義符。例如， 'n' 匹配字符'n'。'\n' 匹配換行符。序列'\\' 匹配"\"，而'\(' 則匹配"("。
 ^    匹配輸入字符串的開始位置，除非在方括號表達式中使用，此時它表示不接受該字符集合。要匹配^ 字符本身，請使用\^。
 {    標記限定符表達式的開始。要匹配{，請使用\{。
 |    指明兩項之間的一個選擇。要匹配|，請使用\|。
 
 限定字符    描述
 *    匹配前面的子表達式零次或多次。例如，zo* 能匹配"z" 以及"zoo"。* 等價於{0,}。
 +    匹配前面的子表達式一次或多次。例如，'zo+' 能匹配"zo" 以及"zoo"，但不能匹配"z"。+ 等價於{1,}。
 ?    匹配前面的子表達式零次或一次。例如，"do(es)?" 可以匹配"do" 、 "does" 中的"does" 、 "doxy" 中的"do" 。? 等價於{0,1}。
 {n}    n 是一個非負整數。匹配確定的n 次。例如，'o{2}' 不能匹配"Bob" 中的'o'，但是能匹配"food" 中的兩個o。
 {n,}    n 是一個非負整數。至少匹配n 次。例如，'o{2,}' 不能匹配"Bob" 中的'o'，但能匹配"foooood" 中的所有o。'o{1,}' 等價於'o+'。'o{0,}' 則等價於'o*'。
 {n,m}    m 和n 均為非負整數，其中n <= m。最少匹配n 次且最多匹配m 次。例如，"o{1,3}" 將匹配"fooooood" 中的前三個o。'o{0,1}' 等價於'o?'。請注意在逗號和兩個數之間不能有空格。
 
 定位字符    描述
 ^    匹配輸入字符串開始的位置。如果設置了RegExp 對象的Multiline 屬性，^ 還會與\n 或\r 之後的位置匹配。
 $    匹配輸入字符串結尾的位置。如果設置了RegExp 對象的Multiline 屬性，$ 還會與\n 或\r 之前的位置匹配。
 \b    匹配一個單詞邊界，即字與空格間的位置。
 \B    非單詞邊界匹配。
 
 */
