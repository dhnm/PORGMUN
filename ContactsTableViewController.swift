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
        
        let appURL = NSURL(string: "fb://page?id=1443688759205321")!
        let webURL = NSURL(string: "https://www.facebook.com/porgmun")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
        
    }
    
    @IBAction func instagramButton(_ sender: Any) {
        
        let appURL = NSURL(string: "instagram://user?username=porgmun")!
        let webURL = NSURL(string: "https://www.instagram.com/porgmun/")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
        
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        
        let appURL = NSURL(string: "twitter://user?screen_name=porgmun")!
        let webURL = NSURL(string: "https://www.twitter.com/porgmun")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
        
    }
    
    // [class] místo [dictionary]
    
    let data: [[String: String]] = [
        
        [
            "ignore": "me"
        ],
        
        [
            "name": "Sára Davidová",
            "occupation": "Secretary-General",
            "e-mail": "secretariat@porgmun.cz",
            "phone": "+420 773 194 105",
            "picture": "sara.jpg"
        ],
        
        [
            "name": "Šimon Olmer",
            "occupation": "Deputy Secretary-General",
            "e-mail": "olmer@porgmun.cz",
            "phone": "+420 725 552 226",
            "picture": "simon.jpg"
        ],
        
        [
            "name": "Barbora Lišková\nLeah Koutná",
            "occupation": "Heads of Registration",
            "e-mail": "registration@porgmun.cz",
            "phone": "+420 602 395 396",
            "picture": "bara-leah.jpg"
        ],
        
        [
            "name": "Josef Bratršovský",
            "occupation": "Student Chief Officer",
            "e-mail": "secretariat@porgmun.cz",
            "phone": "+420 721 109 221",
            "picture": "josef.jpg"
        ],
        
        [
            "name": "Zach Barnes",
            "occupation": "Chief Supervisor",
            "e-mail": "barnes@porgmun.cz",
            "phone": "+420 777 251 829",
            "picture": ""
        ],
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return data.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
            
        }
        
        var rows = 0
        
        if data[section]["picture"] != "" {
            
            rows += 1
            
        }
        
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
            
            return 330
            
        }
        
        return UITableViewAutomaticDimension
        
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
                    cell.accessoryType = UITableViewCellAccessoryType.none
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
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
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
                    let alert = UIAlertController(title: "Copied to Clipboard", message: "E-mail address copied to clipboard.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            } else if indexPath.row == 2 {
                
                let phoneNumberString = data[indexPath.section]["phone"]
                
                if phoneNumberString != "" {
                    
                    let phoneNumber = phoneNumberString!.components(separatedBy: .whitespaces).joined()
                    
                    if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
                        let application: UIApplication = UIApplication.shared
                        if (application.canOpenURL(phoneCallURL)) {
                            application.open(phoneCallURL, options: [:], completionHandler: nil)
                        } else {
                            UIPasteboard.general.string = String(phoneNumber)
                            let alert = UIAlertController(title: "Copied to Clipboard", message: "\(phoneNumber) copied to clipboard.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.default, handler: nil))
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
                let alert = UIAlertController(title: "Copied to Clipboard", message: "E-mail address copied to clipboard.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            }
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class ContactsHeaderCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
}