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
    var data = Committee(title: "", abbreviation: "", description: "", topics: [(name: "", description: "", file: nil)], countryMatrix: "")
    var fileURLs = [NSURL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = data.abbreviation
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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
                
                cell.textLabel?.text = data.description
                
            } else if indexPath.section == 2 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
                
                cell.textLabel?.text = data.topics[indexPath.row].name
                
            } else if indexPath.section == 3 {
                
                cell.textLabel?.text = data.countryMatrix
                
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 143.0
            
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 143.0
            
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "topicSegue" {
            
            if let destinationVC = segue.destination as? TopicDetailTableViewController {
                
                let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
                destinationVC.data = data.topics[indexPath.row]
                
            }
            
        }
        
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

class CommitteesCustomCell: UITableViewCell {
    
    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var orgImage: UIImageView!
    
}
