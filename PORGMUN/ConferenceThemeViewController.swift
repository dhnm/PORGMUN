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
    
    mainLabel.font = UIFont(name: "MyriadPro-Regular", size: 16)
    //mainLabel.textColor = .darkGray
    mainLabel.lineBreakMode = .byWordWrapping
    mainLabel.numberOfLines = 0
    mainLabel.delegate = self
    
    let text: [String] = ["Theme of the Conference:", "\nSwinging Back to Democracy", "\nStriving for institutional change in an ever-changing society", "\n\nNew, hybrid threats, devaluation of national sovereignty in favour of globalization, political radicalization and the evident disconnect of the majority from leading political elites are all clear indicators that our current era is steadily rendering our conventional political system obsolete. The need for change is apparent. Essentially, Swinging back to democracy aims to address this issue by discussing the dissolution of the core democratic ideas of responsibility, decisiveness, and trust in the bureaucratic process and re-evaluating the way our society works or even debating on how it should work."]
    
    mainLabel.setText(text.joined(separator: ""), afterInheritingLabelAttributesAndConfiguringWith: { mutableAttributedString in
      let smallRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[0], options: .caseInsensitive)
      let boldRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[1], options: .caseInsensitive)
      let italicRange: NSRange = (mutableAttributedString!.string as NSString).range(of: text[2], options: .caseInsensitive)
      
      // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
      
      let small = UIFont(name: "MyriadPro-Regular", size: 15)!
      let bold = UIFont(name: "MyriadPro-Semibold", size: 18)!
      let italic = UIFont(name: "MyriadPro-It", size: 16)!
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
