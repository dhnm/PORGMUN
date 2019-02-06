//
//  RulesDetailViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 15.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit

class RulesDetailViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textView: UITextView!
  
  var data = (title: "", text: "")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.text = data.text
    titleLabel.text = data.title
  }
}
