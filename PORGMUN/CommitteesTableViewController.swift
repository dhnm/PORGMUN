//
//  InfoTableViewController
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 13.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit

class CommitteesTableViewController: UITableViewController {
  
  @IBOutlet var infoTableView: UITableView!
  
  let committeesArray = try! PropertyListDecoder().decode([Committee].self, from: Data(contentsOf: Bundle.main.url(forResource: "Committees", withExtension: "plist")!))
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return ""
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 && false {
      return 1
    }
    return committeesArray.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 && false {
      let cell = infoTableView.dequeueReusableCell(withIdentifier: "preambleCell", for: indexPath)
      cell.imageView?.image = #imageLiteral(resourceName: "fa-book@3x.png")
      cell.textLabel?.text = "Rules & Procedure"
      return cell
      
    } else {
      let cell = infoTableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
      cell.textLabel?.text = committeesArray[indexPath.row].title
      cell.detailTextLabel?.text = committeesArray[indexPath.row].abbreviation
      cell.imageView?.image = UIImage(named: committeesArray[indexPath.row].abbreviation.lowercased() + ".jpg")
      return cell
    }
  }
  
  /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   let coords = dictionaryHandling(indexPath: indexPath)["coords"] as! CLLocationCoordinate2D
   let initialLocation = CLLocation(latitude: coords.latitude, longitude: coords.longitude)
   centerMapOnLocation(location: initialLocation, radius: 500)
   print("5")
   } */
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let logo = #imageLiteral(resourceName: "logo-black@2x.png")
    let imageView = UIImageView(image: logo)
    self.navigationItem.titleView = imageView
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    /*
     if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     RecipeDetailViewController *destViewController = segue.destinationViewController;
     destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
     }
     */
    if segue.identifier == "committeeDetailSegue" {
      if let destinationVC = segue.destination as? CommitteesDetailTableViewController {
        let indexPath: IndexPath = self.infoTableView.indexPathForSelectedRow!
        destinationVC.data = committeesArray[indexPath.row]
      }
    }
  }
}

struct Committee: Decodable {
  
  let title: String
  let abbreviation: String
  let description_: String
  let topics: [Topic]
  let countryMatrix: String
  
  struct Topic: Decodable {
    
    let name: String
    let description_: String
    let fileName: String?
  }
}
