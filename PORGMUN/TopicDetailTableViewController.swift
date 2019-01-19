//
//  TopicDetailTableViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 10/03/2018.
//  Copyright © 2018 dhnm. All rights reserved.
//

import UIKit
import WebKit

class TopicDetailTableViewController: UITableViewController, UIDocumentInteractionControllerDelegate, FileManagerDelegate {
  
  var data: (name: String, description: String, file: String?) = (name: "", description: "", file: nil)
  var documentInteractionController: UIDocumentInteractionController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logo = #imageLiteral(resourceName: "logo-black@2x.png")
    let imageView = UIImageView(image:logo)
    self.navigationItem.titleView = imageView
    
    func copyFiles(fileName: String) -> URL {
      let filemgr = FileManager.default
      filemgr.delegate = self
      
      let tempDocsFolder = NSTemporaryDirectory()
      
      let fileSplit = fileName.components(separatedBy: ".")
      let filePath = Bundle.main.path(forResource: fileSplit[0], ofType: fileSplit[1])
      let destPath = "\(tempDocsFolder)/\(fileName)"
      
      do {
        try? filemgr.copyItem(atPath: filePath!, toPath: destPath)
      }
      return URL.init(fileURLWithPath: destPath)
    }
    
    if let fileName = data.file {
      /*let fileSplit = fileName.components(separatedBy: ".")
       let fileURL = Bundle.main.url(forResource: fileSplit[0], withExtension: fileSplit[1])*/
      documentInteractionController = UIDocumentInteractionController(url: copyFiles(fileName: fileName))
      documentInteractionController.delegate = self
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    var sections = 1
    if data.description != "" {
      sections += 1
    }
    if data.file != nil {
      sections += 1
    }
    return sections
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ""
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopicGenericCell", for: indexPath)
    if indexPath.section == 0 {
      cell.textLabel?.text = data.name
      cell.textLabel?.font = UIFont(name:"ProximaNova-Semibold", size: 17.0)
      
    } else if indexPath.section == 2 {
      cell.textLabel?.textAlignment = .justified
      cell.textLabel?.text = data.description
      
    } else if indexPath.section == 1 {
      
      if data.file == nil {
        cell.textLabel?.textAlignment = .justified
        cell.textLabel?.text = data.description
      } else {
        cell.isUserInteractionEnabled = true
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Research Paper"
      }
    }
    return cell
  }
  
  func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
    return self
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    documentInteractionController.presentPreview(animated: true)
  }
}
