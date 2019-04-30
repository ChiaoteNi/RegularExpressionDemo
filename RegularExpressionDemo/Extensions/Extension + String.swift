//
//  Extension + String.swift
//  Attr_Range_RegularExpTest
//
//  Created by admin on 2019/4/5.
//  Copyright © 2019 aaronni. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func matches(for regex: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            return regex.matches(in: self, range: NSRange.init(location: 0, length: count))
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func getMatchedTxts(for regex: String) -> [String] {
        let results: [NSTextCheckingResult] = matches(for: regex)
        let result = results.compactMap { String(self[Range($0.range, in: self)!]) }
        return result
    }
    
    func getMatchedRanges(for regex: String) -> [NSRange] {
        let results: [NSTextCheckingResult] = matches(for: regex)
        let result = results.compactMap { $0.range }
        return result
    }
    
    //MARK: - 識別並轉換emoji文字
    func convertAttrStrToEmoji(fontSize: CGFloat) -> NSMutableAttributedString? {
        guard count != 0 else { return nil }
        let mutableText = NSMutableAttributedString.init()

        let attrs: [NSAttributedString.Key : Any] = [
//            .foregroundColor: UIColor.red,
//            .backgroundColor: UIColor.green,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        let attachment = NSMutableAttributedString.init(string: self, attributes: attrs)
        mutableText.setAttributedString(attachment)
        // 識別emoji字元
        let regexArray = matches(for: "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]").reversed()
        
        for result: NSTextCheckingResult in regexArray {
            // get name
            let range = result.range
            let name = (self as NSString).substring(with: range)
            // set image
            guard let img = UIImage(named: name)?.withRenderingMode(.alwaysOriginal) else { continue }
            let textAttachment = NSTextAttachment(data: nil, ofType: nil)
            textAttachment.image = img
            // resize
            textAttachment.bounds = CGRect.init(x: 0, y: -fontSize/6, width: fontSize, height: fontSize)
            let textAttachmentString = NSAttributedString(attachment: textAttachment)
            mutableText.replaceCharacters(in: range, with: textAttachmentString)
            mutableText.insert(textAttachmentString, at: 0)
        }
        mutableText.addAttributes(attrs, range: NSRange.init(location: 0, length: mutableText.length))
        return mutableText
    }
}

