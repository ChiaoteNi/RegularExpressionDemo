//
//  BaseVC.swift
//  Attr_Range_RegularExpTest
//
//  Created by admin on 2019/4/8.
//  Copyright © 2019 aaronni. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    var closeBtn: UIButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeBtn.setTitle("", for: .normal)
        closeBtn.setImage(#imageLiteral(resourceName: "closeBtn"), for: .normal)
        closeBtn.frame = CGRect(x: UIScreen.main.bounds.width - 30, y: 50, width: 20, height: 20)
        closeBtn.addTarget(self, action: #selector(close), for: UIControl.Event.allEvents)
        view.insertSubview(closeBtn, at: 0)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
