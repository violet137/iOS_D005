//
//  LocationSupportViewController.swift
//  OrderNow
//
//  Created by ADMIN on 9/13/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import GoogleMaps

class LocationSupportViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager : CLLocationManager?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView?.settings.myLocationButton = true;
        mapView?.isMyLocationEnabled = true;
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation? = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: location?.coordinate.latitude ?? 0, longitude: location?.coordinate.longitude ?? 0, zoom: 16)
        
        mapView?.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            break;
        case .authorizedWhenInUse:
            print("Permission OK")
            break;
        default:
            print("Permission Error \(status)")
            break;
        }
    }
    

}
