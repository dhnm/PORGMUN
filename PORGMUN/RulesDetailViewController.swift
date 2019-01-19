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
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView

        // Do any additional setup after loading the view.
        
        textView.text = data.text
        titleLabel.text = data.title
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
