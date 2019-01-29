//
//  ViewController.swift
//  SwiftXMLParsingDemo
//

import UIKit
import TTTAttributedLabel
import SafariServices
import MessageUI
import SystemConfiguration

class NewsViewController: UITableViewController, TTTAttributedLabelDelegate, SFSafariViewControllerDelegate, MFMailComposeViewControllerDelegate {
  
  // ukládat zprávy do internal storage (UserDefaults/CoreData/Documents Storage)
  
  @IBAction func updateButton(_ sender: Any) {
    openSafariViewController(url: URL(string: "https://www.porgmun.cz")!)
  }
  
  var posts = [Post]()
  var reloadButton = UIBarButtonItem()
  let accessToken = "356238391442895|73e76b8d3524e3651fb22675682b54d0".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
  
  func triggerError(_ code: Int) {
    if code == 1 {
      let errorPost = Post(data: (["message": "Error loading feed. Please check your internet connection."] as AnyObject))
      self.posts.insert(errorPost, at: 0)
    } else {
      let errorPost = Post(data: (["message": "App Error. Please inform the PORGMUN Team asap."] as AnyObject))
      self.posts.insert(errorPost, at: 0)
    }
    
    if code == 2 {
      print("Error making URL")
    }
    
    refreshControl?.endRefreshing()
    tableView.reloadData()
  }
  
  func callAPI() {
    let graphURL = URL(string: "https://graph.facebook.com/v2.8/1443688759205321/posts?&fields=id,story,message,created_time,link,attachments,admin_creator,status_type,type,description,from,story_tags,icon,source,full_picture,name&access_token=\(accessToken)")
    
    if let graphURLSafe = graphURL {
      let task = URLSession.shared.dataTask(with: graphURLSafe) { data, response, error in
        if let error = error {
          print(error)
        } else {
          if let urlContent = data {
            do {
              let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as AnyObject
              
              if let dataFromJson = jsonResult["data"] as? Array<AnyObject> {
                
                for (index, aData) in dataFromJson.enumerated() {
                  let aPost = Post(data: aData)
                  self.posts.append(aPost)
                  
                  if let imageURLSafe = aPost.imageURL {
                    URLSession.shared.dataTask(with: imageURLSafe) { (data, response, error) in
                      
                      if let errorSafe = error {
                        print("Failed fetching image:", errorSafe)
                        return
                      }
                      
                      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        print("Not a proper HTTPURLResponse or statusCode")
                        return
                      }
                      
                      if let dataSafe = data {
                        let image = UIImage(data: dataSafe)
                        //aPost.image = (image!, image!.size.width, image!.size.height)
                        
                        if let imageSafe = image {
                          DispatchQueue.main.sync {
                            //self.posts.append(aPost)
                            //self.posts[index] = aPost
                            self.posts[index].image = (imageSafe, imageSafe.size.width, imageSafe.size.height)
                            self.tableView.reloadData()
                          }
                        }
                      }
                    }.resume()
                  }
                  
                  if aPost.album {
                    let postId = aData["id"] as! String
                    let photoId = postId.components(separatedBy: "_")[1]
                    //print(photoId)
                    let urlString = "https://graph.facebook.com/v2.8/\(photoId)?fields=album&access_token=\(self.accessToken)"
                    //print(urlString)
                    let fetchAlbumURL = URL(string: urlString)
                    
                    if let fetchAlbumURLSafe = fetchAlbumURL {
                      URLSession.shared.dataTask(with: fetchAlbumURLSafe) { data, response, error in
                        if let errorSafe = error {
                          print("Failed fetching url content:", errorSafe)
                          return
                        }
                        
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                          print("Not a proper HTTPURLResponse or statusCode")
                          return
                        }
                        
                        if let albumJSON = data {
                          do {
                            let albumJsonResult = try JSONSerialization.jsonObject(with: albumJSON, options: .mutableContainers) as AnyObject
                            if let albumDict = albumJsonResult["album"] as? [String: String] {
                              if let albumId = albumDict["id"] {
                                //print("here")
                                let albumUrlString = "http://www.facebook.com/" + albumId
                                aPost.albumURL = URL(string: albumUrlString)
                              }
                            }
                          } catch {
                            self.triggerError(0)
                            print("error")
                          }
                        }
                      }.resume()
                    } else {
                      self.triggerError(2)
                    }
                  }
                }
              } else {
                self.triggerError(0)
                print("token expired")
              }
              
              DispatchQueue.main.sync {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
              }
            } catch {
              self.triggerError(0)
              print("JSON Processing Failed")
            }
          }
        }
      }
      task.resume()
    } else {
      triggerError(2)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logo = #imageLiteral(resourceName: "logo-black@2x.png")
    let imageView = UIImageView(image:logo)
    self.navigationItem.titleView = imageView
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(self.updateData), for: .valueChanged)
    self.refreshControl = refreshControl
    
    refreshControl.beginRefreshing()
    updateData()
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 500.0
  }
  
  @objc func updateData() {
    if connectedToNetwork() {
      posts = [Post]()
      callAPI()
    } else {
      triggerError(1)
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return posts.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
    var index: Int = recognizer.view!.tag
    if index < 1000 {
      if let safeLink = posts[index].link {
        openSafariViewController(url: safeLink)
      }
      
    } else {
      index -= 1000
      //print(posts[index].albumURL!)
      if let safeLink = posts[index].albumURL {
        openSafariViewController(url: safeLink)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: CustomTableViewCell
    let post = posts[indexPath.section]
    //        let data = json[indexPath.row]
    let message: String? = post.message
    let date: String? = post.date
    
    if let image = post.image {
      cell = tableView.dequeueReusableCell(withIdentifier: "CellWithImage", for: indexPath) as! CustomTableViewCell
      //if let theImage = post.image {
      
      let imageTuple = image
      cell.postImage.image = imageTuple.img
      cell.postImage.tag = indexPath.section
      let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
      cell.postImage.addGestureRecognizer(tap)
      cell.postImage.isUserInteractionEnabled = true
      
      //cell.postImage?.image = UIImage(data: data!)
      
      //let imageHeightInDevice = cell.postImage.frame.width / ((theImage.size.width) / (theImage.size.height))
      let imageHeightInDevice = cell.postImage.frame.width / (imageTuple.width / imageTuple.height)
      cell.postImageHeightConstraint.constant = imageHeightInDevice
      cell.layoutIfNeeded()
      //} else {
      //let url = URL(string: urlString)
      //                URLSession.shared.dataTask(with: url) { (data, response, error) in
      //                    if error != nil {
      //                        print("Failed fetching image:", error!)
      //                        return
      //                    }
      //
      //                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      //                        print("Not a proper HTTPURLResponse or statusCode")
      //                        return
      //                    }
      //
      //                    DispatchQueue.main.async {
      //                        // pod 'SDWebImage'
      //
      //                        let image = UIImage(data:data!)
      //                        post.image = image
      //                        let aRatio = (image?.size.width)! / (image?.size.height)!
      //                        cell.postImage?.image = UIImage(data: data!)
      //
      //                        let imageWidthInDevice = cell.postImage.frame.width
      //                        let imageHeightInDevice = imageWidthInDevice / aRatio
      //                        cell.postImageHeightConstraint.constant = imageHeightInDevice
      //                        cell.layoutIfNeeded()
      //
      //                        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
      //
      //                        //                    let aRatioConstraint = NSLayoutConstraint(item: cell.postImage, attribute:  NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cell.postImage, attribute: NSLayoutAttribute.height, multiplier: aRatio, constant: 0.0)
      //                        //                    cell.postImage?.addConstraint(aRatioConstraint)
      //
      //                        //let frameHeight = (cell.postImage?.frame.width)! * (image?.size.height)! / (image?.size.width)!
      //
      //                        //let heightConstraint = NSLayoutConstraint(item: cell.postImage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: frameHeight)
      //
      //                        //cell.postImage?.addConstraints([heightConstraint])
      //
      //                    }
      //
      //                    }.resume()
      //}
      if post.album {
        cell.postImage.tag = indexPath.section + 1000
      }
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "CellWithText", for: indexPath) as! CustomTableViewCell
    }
    
    if let _ = message {
      //            print("here")
      //            print(attributedMessage)
      //            print(cell.messageLabel?.text)
      //            print(cell.messageLabel?.attributedText)
      
      cell.messageLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
      //cell.messageLabel.textColor = UIColor.darkGray
      cell.messageLabel.lineBreakMode = .byWordWrapping
      cell.messageLabel.numberOfLines = 0
      cell.messageLabel.enabledTextCheckingTypes = NSTextCheckingResult.CheckingType.link.rawValue
      cell.messageLabel.delegate = self
      
      let linkAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black,
        .font: UIFont(name: "ProximaNova-Semibold", size: 16)!
      ]
      let activeLinkAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.black.withAlphaComponent(0.80),
        .underlineStyle: NSNumber(value: true)
      ]
      
      cell.messageLabel.linkAttributes = linkAttributes
      cell.messageLabel.activeLinkAttributes = activeLinkAttributes
      
      let text: String = message!
      
      cell.messageLabel.setText(text, afterInheritingLabelAttributesAndConfiguringWith: { mutableAttributedString in
        let boldRange = (mutableAttributedString!.string as NSString).range(of: "ipsum dolor", options: .caseInsensitive)
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        let boldFont = UIFont(name: "ProximaNova-Semibold", size: 16)!
        let font = CTFontCreateWithName(boldFont.fontName as CFString, boldFont.pointSize, nil)
        mutableAttributedString?.addAttribute(NSAttributedString.Key(kCTFontAttributeName as String), value: font, range: boldRange)
        return mutableAttributedString!
      })
      
      //cell.messageLabel?.text = attributedMessage as? String
      
    } else if let storySafe = post.story {
      cell.messageLabel?.text = storySafe
    } else {
      cell.messageLabel?.text = ""
    }
    
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .medium
    
    if let _ = date {
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      let dateLabel = formatter.date(from: date!)
      formatter.timeStyle = .short
      formatter.dateStyle = .medium
      cell.dateLabel?.text = formatter.string(from: dateLabel!)
      
    } else {
      let now = Date()
      cell.dateLabel?.text = formatter.string(from: now)
    }
    
    if let icon = post.icon {
      cell.postIcon?.image = icon
      
    } else {
      var iconURL = post.iconURL
      if iconURL == nil {
        iconURL = URL(string: "https://www.facebook.com/images/icons/post.gif")
      }
      
      if let iconURLSafe = iconURL {
        URLSession.shared.dataTask(with: iconURLSafe) { data, response, error in
          if error != nil {
            print("Failed fetching image:", error!)
            return
          }
          
          guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Not a proper HTTPURLResponse or statusCode")
            return
          }
          
          DispatchQueue.main.sync {
            let icon = UIImage(data: data!)
            post.icon = icon
            cell.postIcon?.image = icon
          }
        }.resume()
        
      } else {
        triggerError(2)
      }
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
    return 0.00001
  }
  
  func openSafariViewController(url: URL) {
    let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: false)
    if #available(iOS 10.0, *) {
      safariViewController.preferredControlTintColor = .black
    }
    safariViewController.delegate = self
    present(safariViewController, animated: true, completion: nil)
  }
  
  func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
    let mailtoCheck = url.absoluteString[...url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 7)]
    let httpCheck = url.absoluteString[...url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 4)]
    
    if httpCheck == "http" {
      openSafariViewController(url: url)
      
    } else if mailtoCheck == "mailto:" {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        let recipient = String(url.absoluteString[url.absoluteString.index(url.absoluteString.startIndex, offsetBy: 7)...])
        mail.setToRecipients([recipient])
        mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
        present(mail, animated: true)
      } else {
        print("email failed")
      }
    }
  }
  
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}

class CustomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var contView: UIView!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var messageLabel: TTTAttributedLabel!
  @IBOutlet weak var postIcon: UIImageView!
  @IBOutlet weak var postImage: UIImageView!
  @IBOutlet weak var postImageHeightConstraint: NSLayoutConstraint!
}

//
//  Post.swift
//  SwiftXMLParsingDemo
//
//  Created by Nhat Minh Dinh Huy on 25/02/2017.
//  Copyright © 2017 creativeinfoway. All rights reserved.
//

class Post: NSObject {
  
  var imageURL: URL?
  var iconURL: URL?
  var message: String?
  var image: (img: UIImage, width: CGFloat, height: CGFloat)?
  var icon: UIImage?
  var date: String?
  var link: URL?
  var album: Bool = false
  var story: String?
  var albumURL: URL?
  
  init(data: AnyObject) {
    if let imageURLString = data["full_picture"] as? String {
      imageURL = URL(string: imageURLString)
    }
    message = data["message"] as? String
    date = data["created_time"] as? String
    if let linkString = data["link"] as? String {
      
      link = URL(string: linkString)
      
    }
    if let iconUrlSring = data["icon"] as? String {
      iconURL = URL(string: iconUrlSring)
    }
    if let statusType = data["status_type"] as? String {
      if statusType == "added_photos" {
        if let attachments = data["attachments"] as? [String: Array<AnyObject>] {
          if let arrayContent = attachments["data"]?[0] {
            let subattachments = arrayContent["subattachments"] as AnyObject
            if (subattachments["data"] as? Array<AnyObject>) != nil {
              //print("a")
              //print(subattdata)
              album = true
            }
          }
        }
      }
    }
    story = data["story"] as? String
  }
}

func connectedToNetwork() -> Bool {
  var zeroAddress = sockaddr_in()
  zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
  zeroAddress.sin_family = sa_family_t(AF_INET)
  
  guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
      SCNetworkReachabilityCreateWithAddress(nil, $0)
    }
  }) else {
    return false
  }
  
  var flags: SCNetworkReachabilityFlags = []
  if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
    return false
  }
  
  let isReachable = flags.contains(.reachable)
  let needsConnection = flags.contains(.connectionRequired)
  
  return isReachable && !needsConnection
}
