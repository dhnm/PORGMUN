//
//  ContactsTableViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 09/02/2017.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import MessageUI

class ContactsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
  
  @IBAction func facebookButton(_ sender: Any) {
    let appURL = URL(string: "fb://page?id=1443688759205321")!
    let webURL = URL(string: "https://www.facebook.com/porgmun")!
    let application = UIApplication.shared
    if application.canOpenURL(appURL) {
      application.openURL(appURL)
    } else {
      application.openURL(webURL)
    }
  }
  
  @IBAction func instagramButton(_ sender: Any) {
    let appURL = URL(string: "instagram://user?username=porgmun")!
    let webURL = URL(string: "https://www.instagram.com/porgmun/")!
    let application = UIApplication.shared
    if application.canOpenURL(appURL) {
      application.openURL(appURL)
    } else {
      application.openURL(webURL as URL)
    }
  }
  
  @IBAction func twitterButton(_ sender: Any) {
    let appURL = URL(string: "twitter://user?screen_name=porgmun")!
    let webURL = URL(string: "https://www.twitter.com/porgmun")!
    let application = UIApplication.shared
    if application.canOpenURL(appURL) {
      application.openURL(appURL)
    } else {
      application.openURL(webURL)
    }
  }
  
  // [class] místo [dictionary]
  
  let data: [[String: String]] = [
    [
      "ignore": "me"
    ], [
      "name": "Šimon Olmer",
      "occupation": "Secretary-General",
      "e-mail": "olmer@porgmun.cz",
      "phone": "+420 725 552 226",
      "picture": "simon.jpg"
    ], [
      "name": "Barbora Lišková",
      "occupation": "Deputy Secretary-General",
      "e-mail": "secretariat@porgmun.cz",
      "phone": "+420 602 777 223",
      "picture": "bara.jpg"
    ], [
        "name": "Vanesa Kerle",
        "occupation": "Deputy Secretary-General",
        "e-mail": "secretariat@porgmun.cz",
        "phone": "+420 608 033 531",
        "picture": "vanesa.jpg"
    ], [
      "name": "Ela Tarcalová",
      "occupation": "Head of Registration",
      "e-mail": "registration@porgmun.cz",
      "phone": "+420 725 463 454",
      "picture": "ela.jpg"
    ], [
        "name": "Lucie Čapková",
        "occupation": "Student Chief Officer",
        "e-mail": "capkova@porgmun.cz",
        "phone": "+420 725 366 700",
        "picture": "lucy.jpg"
    ], [
      "name": "Zach Barnes",
      "occupation": "Chief Supervisor",
      "e-mail": "barnes@porgmun.cz",
      "phone": "+420 777 251 829",
      "picture": ""
    ]
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logo = #imageLiteral(resourceName: "logo-black@2x.png")
    let imageView = UIImageView(image: logo)
    self.navigationItem.titleView = imageView
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    }
    var rows = 1
    if data[section]["phone"] != "" {
      rows += 1
    }
    if data[section]["e-mail"] != "" {
      rows += 1
    }
    return rows
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section != 0 && indexPath.row == 0 && data[indexPath.section]["picture"] != "" {
      return 285
    }
    return UITableView.automaticDimension
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    let contact = data[indexPath.section]
    if indexPath.section != 0 {
      if indexPath.row == 0 {
        if contact["picture"] != "" {
          cell = tableView.dequeueReusableCell(withIdentifier: "ContactsHeaderCell", for: indexPath) as! ContactsHeaderCell
          (cell as! ContactsHeaderCell).picture?.image = UIImage(named: contact["picture"]!)
          (cell as! ContactsHeaderCell).occupationLabel?.text = contact["occupation"]!
          (cell as! ContactsHeaderCell).nameLabel?.text = contact["name"]!
          
        } else {
          cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath)
          cell.textLabel?.text = contact["name"]
          cell.detailTextLabel?.text = contact["occupation"]
          cell.accessoryType = .none
          cell.isUserInteractionEnabled = false
        }
        
      } else {
        cell = tableView.dequeueReusableCell(withIdentifier: "ContactItemCell", for: indexPath)
        if indexPath.row == 1 {
          cell.textLabel?.text = contact["e-mail"]!
        } else if indexPath.row == 2 {
          cell.textLabel?.text = contact["phone"]!
        }
      }
      
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath)
      cell.textLabel?.text = "it@porgmun.cz"
      cell.detailTextLabel?.text = "App Feedback & Bug Report"
      cell.accessoryType = .disclosureIndicator
      cell.isUserInteractionEnabled = true
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //if !connectedToNetwork() {
    //return 0.00001
    //}
    return 18.0
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.0001
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section != 0 {
      if indexPath.row == 1 {
        if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.mailComposeDelegate = self
          let recipient = data[indexPath.section]["e-mail"]
          if let recipientSafe = recipient {
            mail.setToRecipients([recipientSafe])
          }
          mail.setMessageBody("<p>Hi!</p>", isHTML: true)
          present(mail, animated: true)
          
        } else {
          UIPasteboard.general.string = data[indexPath.section]["e-mail"]
          let alert = UIAlertController(title: "Copied to Clipboard", message: "E-mail address copied to clipboard.", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
        
      } else if indexPath.row == 2 {
        let phoneNumberString = data[indexPath.section]["phone"]
        if phoneNumberString != "" {
          let phoneNumber = phoneNumberString!.components(separatedBy: .whitespaces).joined()
          if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
              application.openURL(phoneCallURL)
              
            } else {
              UIPasteboard.general.string = String(phoneNumber)
              let alert = UIAlertController(title: "Copied to Clipboard", message: "\(phoneNumber) copied to clipboard.", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
              self.present(alert, animated: true, completion: nil)
            }
          }
        }
        tableView.deselectRow(at: indexPath, animated: true)
      }
      
    } else if indexPath.row == 0 {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["it@porgmun.cz"])
        mail.setMessageBody("<p>Hi! I am writing to you regarding the iOS App.</p>", isHTML: true)
        present(mail, animated: true)
        
      } else {
        UIPasteboard.general.string = "it@porgmun.cz"
        let alert = UIAlertController(title: "Copied to Clipboard", message: "E-mail address copied to clipboard.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

class ContactsHeaderCell: UITableViewCell {
  
  @IBOutlet weak var picture: UIImageView!
  @IBOutlet weak var occupationLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    occupationLabel.layer.shadowColor = UIColor.black.cgColor
    occupationLabel.layer.shadowOpacity = 0.4
    occupationLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    occupationLabel.layer.shadowRadius = 4
    occupationLabel.layer.rasterizationScale = UIScreen.main.scale
    occupationLabel.layer.shouldRasterize = true
    
    nameLabel.layer.shadowColor = UIColor.black.cgColor
    nameLabel.layer.shadowOpacity = 0.4
    nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    nameLabel.layer.shadowRadius = 4
    nameLabel.layer.rasterizationScale = UIScreen.main.scale
    nameLabel.layer.shouldRasterize = true
  }
}
