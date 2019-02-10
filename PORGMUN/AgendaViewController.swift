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

class AgendaViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    
    @IBAction func moveToMyLocation(_ sender: Any) {
        checkLocationAuthorizationStatus()
        locationManager.startUpdatingLocation()
    }
    @IBAction func moveToDefaultLocation(_ sender: Any) {
        self.centerMapOnDefaultLocation()
    }
    
    var selectedPin = MapPointClass(title: "", address: "", color: "", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), directionsText: [""], fonts: [UIFont()])
    
    func centerMapOnLocation(location: CLLocation, radius: Int) {
        let regionRadius = CLLocationDistance(radius)
        let latitude = location.coordinate.latitude - 0.042 * (Double(radius)/6000)
        let convertedLocation = CLLocation(latitude: latitude, longitude: location.coordinate.longitude)
        let coordinateRegion = MKCoordinateRegion(center: convertedLocation.coordinate, latitudinalMeters: regionRadius * 3.0, longitudinalMeters: regionRadius * 3.0)
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
        MapPointClass(title: "Klub FAMU",
                      address: "Smetanovo nábřeží 2",
                      color: "orange",
                      coordinate: CLLocationCoordinate2D(latitude: 50.0817268, longitude: 14.4110277),
                      directionsText: ["Instructions not available. Please, use the Apple Maps button above."],
                      fonts: [UIFont(name: "ProximaNova-RegularIt", size: 15)!]),
        MapPointClass(title: "Vnitroblock",
                      address: "Tusarova 791/31",
                      color: "purple",
                      coordinate: CLLocationCoordinate2D(latitude: 50.1018732, longitude: 14.4492928),
                      directionsText: ["Instructions not available. Please, use the Apple Maps button above."],
                      fonts: [UIFont(name: "ProximaNova-RegularIt", size: 15)!]),
        ]
    
    @objc func centerMapOnDefaultLocation() {
        let lat: CLLocationDegrees = 50.090000
        let lon: CLLocationDegrees = 14.427630
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        centerMapOnLocation(location: initialLocation, radius: 1600)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = #imageLiteral(resourceName: "logo-black@2x.png")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        //    let titleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.centerMapOnDefaultLocation))
        //
        //    self.navigationItem.titleView?.isUserInteractionEnabled = true
        //    self.navigationItem.titleView?.addGestureRecognizer(titleTapRecognizer)
        
        mapView.showsUserLocation = true
        mapView.addAnnotations(mapPoints)
        mapView.delegate = self
        locationManager.delegate = self
        //        mapView.isHidden = true
        self.centerMapOnDefaultLocation()
        
        // blurred tableView
        
        if !UIAccessibility.isReduceTransparencyEnabled {
            tableView.backgroundColor = UIColor(white: 1.00, alpha: 0.00)
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            tableView.backgroundView = blurEffectView
            tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        } else {
            tableView.backgroundColor = UIColor.white
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse || !CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            centerMapOnLocation(location: myLocation, radius: 1600)
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
    }
    
    // table view
    
    let schedule = [
        "Thursday 21st THE OPENING DAY": [
            "10:00–12:00": ["Registration", "1", "red"],
            "12:00-13:30": ["Opening Ceremony", "1", "red"],
            "13:30-14:30": ["Lunch Break", "1", "red"],
            "13:30-13:45": ["Meeting with Supervisors", "1", "red"],
            "14:30-16:00": ["Opening Ceremony", "1", "red"],
            "16:15–18:45": ["Prague Tour and Icebreakers", "1", "red"],
            "19:00–21:30": ["Gala Dinner", "3", "purple"],
        ],
        "Friday 22nd COMMITTEES IN SESSION": [
            "08:30-09:00": ["Chair's Briefing", "0", "porgmun"],
            "09:00–15:00": ["Committee Sessions", "0", "porgmun"],
            "09:15-09:30": ["Meeting with Supervisors", "0", "porgmun"],
            "12:00–14:00": ["Staggered Lunches", "0", "porgmun"]
        ],
        "Saturday 23rd COMMITTEES IN SESSION": [
            "08:30-09:00": ["Chair's Briefing", "0", "porgmun"],
            "09:00–17:00": ["Committees Sessions", "0", "porgmun"],
            "09:15-09:30": ["Meeting with Supervisors", "0", "porgmun"],
            "12:00–14:00": ["Staggered Lunches", "0", "porgmun"],
            "20:00–24:00": ["Official PORGMUN Party", "2", "orange"]
        ],
        "Sunday 24th THE CLOSING DAY": [
            "09:00-11:30": ["Further Programme in Committees", "0", "porgmun"],
            "09:15-09:30": ["Meeting with Supervisors", "0", "porgmun"],
            "11:30-13:00": ["Free Time for Lunch and Transfer", "0", "porgmun"],
            "13:00-14:30": ["Closing Ceremony", "1", "red"]
        ]
    ]
    
    let keysArray = ["Thursday 21st THE OPENING DAY", "Friday 22nd COMMITTEES IN SESSION", "Saturday 23rd COMMITTEES IN SESSION", "Sunday 24th THE CLOSING DAY"]
    
    func dictionaryHandling(indexPath: IndexPath) -> [String: Any] {
        let eventsOnThisDate = schedule[keysArray[indexPath.section]]
        let timesOfEvents = Array(eventsOnThisDate!.keys).sorted(by: { (s1: String, s2: String) -> Bool in return s1 < s2 } )
        let titlePlaceColor = eventsOnThisDate![timesOfEvents[indexPath.row]]
        
        let timesString = timesOfEvents[indexPath.row]
        let startTimeIndex = timesString.index(timesString.startIndex, offsetBy: 5)
        let endTimeIndex = timesString.index(timesString.startIndex, offsetBy: 6)
        
        let index = Int((titlePlaceColor?[1])!)!
        
        let startTime = String(timesString[..<startTimeIndex])
        let endTime = String(timesString[endTimeIndex...])
        let placeName = titlePlaceColor![0]
        var address = mapPoints[index].title!
        if address == "Wenceslas Square" {
            address = "Meeting Point: " + address
        }
        // let colorTagImage = UIImage(named: "\(mapPoints[index].color).png")
        
        let colorTagImage = UIImage(named: "\(titlePlaceColor![2]).png")!
        let coords = mapPoints[index].coordinate
        return [
            "startTime": startTime,
            "endTime": endTime,
            "timesString": timesString,
            "placeName": placeName,
            "address": address,
            "colorTagImage": colorTagImage,
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
        var addressDictionary: [String: Any] = [:]
        addressDictionary[CNPostalAddressStreetKey] = subtitle
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}

extension AgendaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keysArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (schedule[keysArray[section]]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        let computed = dictionaryHandling(indexPath: indexPath)
        cell.startTime?.text = computed["timesString"] as! String?
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
        let convertedLatitude = coords.latitude + 0.002
        print(convertedLatitude)
        
        let initialLocation = CLLocation(latitude: convertedLatitude, longitude: coords.longitude)
        
        centerMapOnLocation(location: initialLocation, radius: 600)
        
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
            return .leastNormalMagnitude
        }
        return tableView.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .red
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont(name: "ProximaNova-Semibold", size: 14)
        
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
    }
}

extension AgendaViewController : MKMapViewDelegate {
    
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
                    view.pinTintColor = .orange
                    
                case "purple":
                    view.pinTintColor = .purple
                    
                default:
                    view.pinTintColor = .red
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
                    view.pinTintColor = .orange
                    
                case "purple":
                    view.pinTintColor = .purple
                    
                default:
                    view.pinTintColor = .red
                    
                }
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        invokeSegue(view)
    }
}
