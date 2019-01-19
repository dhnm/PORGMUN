//
//  DetailTableViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 13.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import QuickLook

class DetailTableViewController: UITableViewController, QLPreviewControllerDataSource {
    
    let quickLookController = QLPreviewController()
    var data = Committee(title: "", abbreviation: nil, img: nil, topics: nil, chairs: nil, files: nil)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abbrLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var topic1: UILabel!
    @IBOutlet weak var topic2: UILabel!
    
    @IBOutlet weak var chair1: UILabel!
    @IBOutlet weak var chair2: UILabel!
    
    @IBOutlet weak var file1: UILabel!
    @IBOutlet weak var file2: UILabel!
    
    @IBOutlet weak var fileCell1: UITableViewCell!
    @IBOutlet weak var fileCell2: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickLookController.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        titleLabel.text = data.title[0]
        abbrLabel.text = data.abbreviation?[0]
        logo.image = data.img
        
        topic1.text = "– " + (data.topics?[0])!
        
        if data.topics?[1] != "" {
            topic2.text = "– " + (data.topics?[1])!
        }
        
        chair1.text = "– " + (data.chairs?[0])!
        
        if data.chairs?[1] != "" {
            chair2.text = "– " + (data.chairs?[1])!
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 3 {
            
            if data.files?[0] == "" {
                
                return 0
                
            }
            
        }
        
        return UITableViewAutomaticDimension
        
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
        
        if indexPath.section == 3 {
            
            if data.files?[0] == "" {
                
                return 0
                
            } else if data.files?[1] == "" {
                
                if indexPath.row == 1 {
                    
                    file1.text = data.files?[0]
                    return 0
                    
                } else {
                    
                    return 44
                    
                }
                
            } else {
                
                file1.text = data.files?[0]
                file2.text = data.files?[1]
                
            }
            
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    var fileURL = NSURL()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        fileURL = Bundle.main.url(forResource: "SC Rules of Procedure", withExtension: "pdf")! as NSURL
        
        quickLookController.currentPreviewItemIndex = 0
        //navigationController?.pushViewController(quickLookController, animated: true)
        present(quickLookController, animated: true, completion: nil)
        
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        
        return 1
        
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        return fileURL
        
    }
    
    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return processedData.sectionNames[section]
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return processedData.numbersOfRows[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailInfoCell", for: indexPath)
        
        let cellContents = processedData.cellContents as NSArray
        
        if let cellLabelArray = cellContents[indexPath.section] as? Array<String> {
            
            cell.textLabel?.text = cellLabelArray[indexPath.row]
            
        } else {
                    
            cell.imageView?.image = data.img
            
        }
        
        return cell
    }*/

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
