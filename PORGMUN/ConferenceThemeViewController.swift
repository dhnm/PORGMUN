//
//  ConferenceThemeViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 12/03/2017.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class ConferenceThemeViewController: UIViewController, TTTAttributedLabelDelegate {
  
  @IBOutlet weak var mainLabel: TTTAttributedLabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 11.0, *) {
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    mainLabel.font = UIFont(name: "ProximaNova-Regular", size: 18)
    //mainLabel.textColor = .darkGray
    mainLabel.lineBreakMode = .byWordWrapping
    mainLabel.numberOfLines = 0
    mainLabel.delegate = self
    
    let text: [String] = ["Theme of the Conference:", "\n\nEliminating Fear", "\n\nConflict and bias as part of dialogue","\n\nRadicalism, active efforts against cooperation, a lack of commitment to agreements, a lack of respect, and a disconnect of politics from reality seem to be the dominant traits of the current world order. These trends replace progress with stagnation and opposition with hostility, posing real threats to our future.\n\nThey are universal in any socio-political circumstances, because they share a common root. We have lost the ability to communicate and lead productive dialogue. Our culture is teaching us to avoid conflict and thereby, we have become afraid to engage with people that have a different perspective or come from a different background. Rather, we often deem them unworthy of our attention and inspire disrespect and polarisation.\n\nIf we want to grow, we must reconnect and engage in dialogue despite our biases or the possibility of conflict."]
    
    mainLabel.setText(text.joined(separator: ""), afterInheritingLabelAttributesAndConfiguringWith: { mutableAttributedString in
      let smallRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[0], options: .caseInsensitive)
      let boldRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[1], options: .caseInsensitive)
      let italicRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[2], options: .caseInsensitive)
      
      // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
      
      let small = UIFont(name: "ProximaNova-Regular", size: 16)!
      let bold = UIFont(name: "ProximaNova-Semibold", size: 26)!
      let italic = UIFont(name: "ProximaNova-RegularIt", size: 18)!
      let smallFont = CTFontCreateWithName(small.fontName as CFString, small.pointSize, nil)
      let boldFont = CTFontCreateWithName(bold.fontName as CFString, bold.pointSize, nil)
      let italicFont = CTFontCreateWithName(italic.fontName as CFString, italic.pointSize, nil)
      mutableAttributedString?.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: smallFont, range: smallRange)
      mutableAttributedString?.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: boldFont, range: boldRange)
      mutableAttributedString?.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: italicFont, range: italicRange)
      return mutableAttributedString!
    })
  }
}
