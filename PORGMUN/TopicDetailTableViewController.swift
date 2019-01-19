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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
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
        // #warning Incomplete implementation, return the number of rows
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
            cell.textLabel?.textAlignment = NSTextAlignment.justified
            cell.textLabel?.text = data.description
        } else if indexPath.section == 1 {
            
            if data.file == nil {
                cell.textLabel?.textAlignment = NSTextAlignment.justified
                cell.textLabel?.text = data.description
            } else {
                cell.isUserInteractionEnabled = true
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
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
