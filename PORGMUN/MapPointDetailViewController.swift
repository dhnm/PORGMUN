//
//  mapPointDetailViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 18.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import MapKit
import TTTAttributedLabel

class MapPointDetailViewController: UITableViewController, TTTAttributedLabelDelegate {
    
    @IBOutlet weak var showMHDCell: UITableViewCell!
    @IBOutlet weak var offlineDirections: TTTAttributedLabel!
    
    var location = MapPointClass(title: "", address: "", color: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), directionsText: [""], fonts: [UIFont()])
    
    var connectedBool = true
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit]
    
    @IBAction func showMHDPressed(_ sender: Any) {
        
        location.mapItem().openInMaps(launchOptions: launchOptions)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !connectedToNetwork() {
            
            showMHDCell.isUserInteractionEnabled = false
            connectedBool = false
            
        } else {
            
            showMHDCell.isUserInteractionEnabled = true
            connectedBool = true
            
        }
        
        offlineDirections.setText(location.directionsText.joined(separator: ""), afterInheritingLabelAttributesAndConfiguringWith: {(_ mutableAttributedString: NSMutableAttributedString?) -> NSMutableAttributedString in
            
            var ranges = [NSRange]()
            
            for text in self.location.directionsText {
                
                ranges.append((mutableAttributedString!.string as NSString).range(of: text, options: .caseInsensitive))
                
            }
            
            var ctfonts = [CTFont?]()
            
            for font in self.location.fonts {
                
                ctfonts.append(CTFontCreateWithName((font.fontName as CFString), font.pointSize, nil))
                
            }
            
            if ctfonts.contains(where: {$0 == nil}) {} else {
                
                for (index, _) in self.location.directionsText.enumerated() {
                    
                    mutableAttributedString?.addAttribute((kCTFontAttributeName as String), value: (ctfonts[index] as Any), range: ranges[index])
                    
                }
                
            }
            
            return mutableAttributedString!
            
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 && !connectedBool {
            
            return 0
            
        } else {
            
            return 1
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 44
            
        }
        
        return UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 44
            
        }
        
        return 400
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 27.0
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 && !connectedBool {
            
            return 0.00001
            
        } else {
            
            return 27.0
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
