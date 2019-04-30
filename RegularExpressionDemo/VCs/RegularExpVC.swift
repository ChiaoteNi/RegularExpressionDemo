//
//  RegularExpVC.swift
//  Attr_Range_RegularExpTest
//
//  Created by admin on 2019/4/8.
//  Copyright © 2019 aaronni. All rights reserved.
//

import UIKit

class RegularExpVC: BaseVC {
    
    enum DemoType {
        case range
        case filter
    }

    @IBOutlet private weak var patternField: UITextField!
    @IBOutlet private weak var segment: UISegmentedControl!
    @IBOutlet private weak var demoLabel: UILabel!
    
    private var txt: String = ".registerComponent('hahaha',functioblablalba;"
    var pattern: String = "\\.registerComponent\\('([^\']+)'"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternField.delegate = self
        demoLabel.text = txt
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterTxt(withPattern: pattern, for: demoLabel)
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        guard let pattern = patternField.text, pattern.isEmpty == false else { return }
        chageDemoStr(withPattern: pattern, ofType: sender.selectedSegmentIndex == 0 ? .range : .filter, for: demoLabel)
    }
}

extension RegularExpVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let pattern = textField.text, pattern.isEmpty == false else { return }
        
        changeAttributed(withPattern: pattern, for: demoLabel)
    }
    
    private func chageDemoStr(withPattern pattern: String, ofType type: DemoType, for label: UILabel) {
        switch type {
        case .range:
            changeAttributed(withPattern: pattern, for: label)
        case .filter:
            filterTxt(withPattern: pattern, for: label)
        }
    }
    
    private func changeAttributed(withPattern pattern: String, for label: UILabel) {
        let ranges: [NSRange] = txt.getMatchedRanges(for: pattern)
        guard ranges.isEmpty == false else { return }
        
        let attrString = NSMutableAttributedString.init(string: txt)
        for range in ranges {
            attrString.addAttribute(.foregroundColor, value: UIColor.red.cgColor, range: range)
        }
        label.attributedText = attrString
    }
    
    private func filterTxt(withPattern pattern: String, for label: UILabel) {
        let txts: [String] = txt.getMatchedTxts(for: pattern)
        var txt: String = ""
        txts.forEach { txt += $0 }
        demoLabel.text = txt
    }
}
