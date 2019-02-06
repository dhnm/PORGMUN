//
//  CommitteesDetailTableViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 28/02/2017.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import QuickLook

class CommitteesDetailTableViewController: UITableViewController {
  
  let quickLookController = QLPreviewController()
  var data: Committee!
  var fileURLs = [URL]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if #available(iOS 11.0, *) {
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    self.title = data.abbreviation
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 1 {
      return "Description"
    } else if section == 2 {
      return "Topics"
    } else if section == 3 {
      return "Country Matrix"
    }
    return ""
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 3 {
      if data.countryMatrix == "" {
        return 0
      }
    }
    return UITableView.automaticDimension
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else if section == 1 {
      return 1
    } else if section == 2 {
      return data.topics.count
    } else if section == 3 {
      if data.countryMatrix == "" {
        return 0
      }
      return 1
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell
    if indexPath.section == 0 {
      cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! CommitteesCustomCell
      (cell as! CommitteesCustomCell).orgNameLabel?.text = data.title
      (cell as! CommitteesCustomCell).orgImage?.image = UIImage(named: data.abbreviation.lowercased() + ".jpg")
      
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
      if indexPath.section == 1 {
        cell.textLabel?.text = data.description_
        
      } else if indexPath.section == 2 {
        cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        cell.textLabel?.text = data.topics[indexPath.row].name
        
      } else if indexPath.section == 3 {
        cell.textLabel?.textAlignment = .justified
        cell.textLabel?.text = data.countryMatrix
      }
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 143.0
    }
    return UITableView.automaticDimension
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 143.0
    }
    return UITableView.automaticDimension
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "topicSegue" {
      if let destinationVC = segue.destination as? TopicDetailTableViewController {
        let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
        destinationVC.data = data.topics[indexPath.row]
      }
    }
  }
}

class CommitteesCustomCell: UITableViewCell {
  
  @IBOutlet weak var orgNameLabel: UILabel!
  @IBOutlet weak var orgImage: UIImageView!
}
