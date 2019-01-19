//
//  MapViewController.swift
//  PORGMUN
//
//  Created by Nhat Minh Dinh Huy on 12.01.17.
//  Copyright © 2017 dhnm. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func moveToMyLocation(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    var selectedPin = MapPointClass(title: "", address: "", color: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), directionsText: [""], fonts: [UIFont()])
    
    func centerMapOnLocation(location: CLLocation, radius: Int) {
        
        let regionRadius = CLLocationDistance(radius)
        
        let latitude = location.coordinate.latitude - 0.075 * (Double(radius)/6000)
        
        let convertedLocation = CLLocation(latitude: latitude, longitude: location.coordinate.longitude)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(convertedLocation.coordinate, regionRadius * 3.0, regionRadius * 3.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    let mapPoints = [
        
        MapPointClass(title: "Anglo-American University",
                      address: "Letenská 120/5",
                      color: "porgmun",
                      coordinate: CLLocationCoordinate2D(latitude: 50.08998639999999, longitude: 14.409023599999955),
                      directionsText: ["Anglo-American University (Thurn-Taxis Palace)",
                                       
                                       "\n\nAddress:", "\nLetenská 120/5",
                                       
                                       "\n\nMetro station:", "\nMalostranská (Line A)",
                                       
                                       "\n\nTram station:", "\nMalostranská (2, 12, 15, 18, 20, 22, 23, 41)"],
                      fonts: [UIFont(name: "ProximaNova-Semibold", size: 18)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!]),
        
        MapPointClass(title: "Prague City Hall",
                      address: "Mariánské náměstí 2/2",
                      color: "red",
                      coordinate: CLLocationCoordinate2D(latitude: 50.0871095, longitude: 14.417835400000058),
                      directionsText: ["Prague City Hall",
                                       
                                       "\n\nAddress:", "\nMariánské náměstí 2/2",
                                       
                                       "\n\nMetro station:", "\nStaroměstská (Line A), exit Valentinská",
                                       
                                       "\n\nTram station:", "\nStaroměstská (2, 17, 18, 37)"],
                      fonts: [UIFont(name: "ProximaNova-Semibold", size: 18)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!]),
        
        MapPointClass(title: "LUCERNA Marble Hall",
                      address: "Štěpánská 704/61",
                      color: "purple",
                      coordinate: CLLocationCoordinate2D(latitude: 50.08088979999999, longitude: 14.42641530000003),
                      directionsText: ["LUCERNA Marble Hall",
                                       
                                       "\n\nAddress:", "\nŠtěpánská 61",
                                       
                                       "\n\nMetro station:", "\nMůstek (Line A, Line B), exit Vodičkova",
                                       
                                       "\n\nTram station:", "\nVáclavské náměstí (2, 3, 5, 6, 9, 14, 24, 91, 92, 94, 95, 96, 98)"],
                      fonts: [UIFont(name: "ProximaNova-Semibold", size: 18)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!]),
        
        MapPointClass(title: "GRID",
                      address: "Opatovická 160/18",
                      color: "orange",
                      coordinate: CLLocationCoordinate2D(latitude: 50.0795955, longitude: 14.418308600000046),
                      directionsText: ["GRID",
                                       
                                       "\n\nAddress:", "\t\tOpatovická 18",
                                       
                                       "\n\nMetro station:", "\nNárodní třída (Line B)",
                                       
                                       "\n\nTram station:", "\nNárodní třída (2, 9, 11, 13, 14, 18, 22, 23, 93, 97)"],
                      fonts: [UIFont(name: "ProximaNova-Semibold", size: 18)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!,
                              UIFont(name: "ProximaNova-Semibold", size: 15)!,
                              UIFont(name: "ProximaNova-Regular", size: 15)!]),
        
        ]
    
    func titleTapped() {
    
        let lat: CLLocationDegrees = 50.089139
        
        let lon: CLLocationDegrees = 14.417630
        
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        
        centerMapOnLocation(location: initialLocation, radius: 1000)
        
        print("tapped")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let titleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.titleTapped))
        
        self.navigationItem.titleView?.isUserInteractionEnabled = true
        self.navigationItem.titleView?.addGestureRecognizer(titleTapRecognizer)

        
        mapView.addAnnotations(mapPoints)
        
        mapView.delegate = self
        locationManager.delegate = self
        
        //        mapView.isHidden = true
        
        
        // blurred tableView
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
        tableView.backgroundColor = UIColor(white: 1.00, alpha: 0.00)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
        
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        } else {
            tableView.backgroundColor = UIColor.white
        }
        
    }
    
    
    var locationManager = CLLocationManager()
    
    func checkLocationAuthorizationStatus() {
        
        if /*CLLocationManager.authorizationStatus() == .authorizedWhenInUse*/ CLLocationManager.locationServicesEnabled() {
            
            mapView.showsUserLocation = true
            
        } else {
           
            locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            centerMapOnLocation(location: myLocation, radius: 1000)
        }
        self.mapView.showsUserLocation = true
        manager.stopUpdatingLocation()
        
    }
    
    func invokeSegue(_ view: MKAnnotationView) {
        
        selectedPin = view.annotation as! MapPointClass
        
        self.performSegue(withIdentifier: "mapPointSegue", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapPointSegue" {
            
            if let destinationVC: MapPointDetailViewController = segue.destination as? MapPointDetailViewController {
                
                
                destinationVC.location = selectedPin
                
                
            }
            
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        checkLocationAuthorizationStatus()
        
        // let initialLocation = CLLocation(latitude: 50.062111, longitude: 14.437261)
        
        let lat: CLLocationDegrees = 50.089139
        
        let lon: CLLocationDegrees = 14.417630
        
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        
        centerMapOnLocation(location: initialLocation, radius: 1000)
        
    }
    
    
    
    
    // table view
    
    let schedule = [
        
        "Thursday 15th OPENING DAY": [
            
            "10:00–12:00": ["Registration", "1", "red"],
            "12:00-13:30": ["Opening Ceremony", "1", "red"],
            "13:30-14:15": ["Break", "1", "red"],
            "14:15-16:00": ["Opening Ceremony", "1", "red"],
            "16:00-16:15": ["Meeting with Supervisors", "1", "red"],
            "16:15–18:45": ["Prague Tour and Icebreakers", "1", "red"],
            "19:00–21:30": ["Gala Dinner", "2", "purple"],
        ],
        
        "Friday 16th COMMITTEES IN SESSION": [
            
            "09:00–17:00": ["Committees in Session and NGO Presentations", "0", "porgmun"],
            "12:00–14:00": ["Staggered Lunches", "0", "porgmun"]
            
        ],
        
        "Saturday 17th COMMITTEES IN SESSION": [
            
            "09:00–17:00": ["Committees in Session and NGO Presentations", "0", "porgmun"],
            "12:00–14:00": ["Staggered Lunches", "0", "porgmun"],
            "20:00–xx:xx": ["Official PORGMUN Party", "3", "orange"]
            
        ],
        
        "Sunday 18th CLOSING DAY": [
            
            "09:00-11:30": ["Further Programme in Committees", "0", "porgmun"],
            "11:30-13:00": ["Free Time for Lunch and Transfer", "0", "porgmun"],
            "13:00-15:00": ["Closing Ceremony", "1", "red"]
            
        ]
        
    ]
    
    let keysArray = ["Thursday 15th OPENING DAY", "Friday 16th COMMITTEES IN SESSION", "Saturday 17th COMMITTEES IN SESSION", "Sunday 18th CLOSING DAY"]
    
    func dictionaryHandling(indexPath: IndexPath) -> [String: Any] {
        
        let eventsOnThisDate = schedule[keysArray[indexPath.section]]
        let timesOfEvents = Array(eventsOnThisDate!.keys).sorted(by: { (s1: String, s2: String) -> Bool in return s1 < s2 } )
        let titlePlaceColor = eventsOnThisDate![timesOfEvents[indexPath.row]]
        
        let timesString = timesOfEvents[indexPath.row]
        let startTimeIndex = timesString.index(timesString.startIndex, offsetBy: 5)
        let endTimeIndex = timesString.index(timesString.startIndex, offsetBy: 6)
        
        let index = Int((titlePlaceColor?[1])!)!
        
        let startTime = timesString.substring(to: startTimeIndex)
        let endTime = timesString.substring(from: endTimeIndex)
        let placeName = titlePlaceColor?[0]
        var address = mapPoints[index].title
        if address == "Wenceslas Square" {
            address = "Meeting Point: " + address!
        }
        // let colorTagImage = UIImage(named: "\(mapPoints[index].color).png")
        
        let colorTagImage = UIImage(named: "\(titlePlaceColor![2]).png")
        
        let coords = mapPoints[index].coordinate
        
        return [
            "startTime": startTime,
            "endTime": endTime,
            "placeName": placeName!,
            "address": address!,
            "colorTagImage": colorTagImage!,
            "locationIndex": index,
            "coords": coords
        ]
        
    }
    
    
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var colorTagImage: UIImageView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
}


class MapPointClass: NSObject, MKAnnotation {
    let title: String?
    let address: String
    let color: String
    let coordinate: CLLocationCoordinate2D
    let directionsText: [String]
    let fonts: [UIFont]
    
    init(title: String, address: String, color: String, coordinate: CLLocationCoordinate2D, directionsText: [String], fonts: [UIFont]) {
        self.title = title
        self.address = address
        self.color = color
        self.coordinate = coordinate
        self.directionsText = directionsText
        self.fonts = fonts
        
        super.init()
    }
    
    var subtitle: String? {
        return address
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle as Any]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as? [String : Any])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return keysArray.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return keysArray[section]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (schedule[keysArray[section]]?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        let computed = dictionaryHandling(indexPath: indexPath)
        
        cell.startTime?.text = computed["startTime"] as! String?
        cell.endTime?.text = computed["endTime"] as! String?
        cell.titleLabel?.text = computed["placeName"] as! String?
        
        cell.subtitleLabel?.text = computed["address"] as! String?
        cell.colorTagImage?.image = computed["colorTagImage"] as! UIImage?
        
        /*let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.backgroundColor = UIColor(white: 1.00, alpha: 0.80) // alpha doesn nothing here
        
        cell.selectedBackgroundView = blurEffectView*/
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dictData = dictionaryHandling(indexPath: indexPath)
        
        // OPTION 1
        
        let coords = dictData["coords"] as! CLLocationCoordinate2D
        let convertedLatitude = (coords.latitude as Double) + 0.002 as CLLocationDegrees
        print(convertedLatitude)
        
        let initialLocation = CLLocation(latitude: convertedLatitude, longitude: coords.longitude)
        
        centerMapOnLocation(location: initialLocation, radius: 400)
        
        // OPTION 2
        
        let locationIndex = dictData["locationIndex"] as! Int
        let placeName = mapPoints[locationIndex].title
        
        for (index, annotation) in mapView.annotations.enumerated() {
            
            if annotation.title! == placeName {
                
                mapView.selectAnnotation(mapView.annotations[index], animated: true)
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //cell.backgroundColor = UIColor.clear
        
    }
    
    //func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
    //  return CGFloat.leastNormalMagnitude
    
    //}
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return tableView.sectionHeaderHeight + tableView.sectionFooterHeight
            
        }
        
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == keysArray.count - 1 {
            
            return CGFloat.leastNormalMagnitude
            
        }
        
        return tableView.sectionFooterHeight
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.red
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? MapPointClass {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                
                switch annotation.color {
                    
                case "porgmun":
                    view.pinTintColor = UIColor(red:0.00, green:0.36, blue:0.64, alpha:1.00)
                    
                case "orange":
                    view.pinTintColor = UIColor.orange
                    
                case "purple":
                    view.pinTintColor = UIColor.purple
                    
                default:
                    view.pinTintColor = UIColor.red
                    
                }
                
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -8, y: -6)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                
                switch annotation.color {
                    
                case "porgmun":
                    view.pinTintColor = UIColor(red:0.00, green:0.36, blue:0.64, alpha:1.00)
                    
                case "orange":
                    view.pinTintColor = UIColor.orange
                    
                case "purple":
                    view.pinTintColor = UIColor.purple
                    
                default:
                    view.pinTintColor = UIColor.red
                    
                }
                
            }
            
            return view
            
        }
        
        return nil
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        invokeSegue(view)
        
    }
    
}