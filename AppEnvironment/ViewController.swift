//
//  ViewController.swift
//  AppEnvironment
//
//  Created by Evan Xie on 2020/1/19.
//  Copyright © 2020 Evan Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        var text = textView.text ?? ""
        text = text.appending("\(AppConfiguration.type.rawValue)\n\n")
        text = text.appending("\(AppConfiguration.values)")
        
        textView.isEditable = false
        textView.text = text
    }

}

