//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 7. 9..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView: MKMapView!
    var currentLocation: UIButton!
    var zoom: UIButton!
    
    var rotatePin: UIButton!
    
    override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        /*
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        */
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // 현재 위치표시, 줌 버튼 추가
        currentLocation = UIButton()
        zoom = UIButton()
        
        currentLocation.setTitle("현재 위치", for: .normal)
        zoom.setTitle("확대", for: .normal)
        
        currentLocation.setTitleColor(UIColor.red, for: .normal)
        zoom.setTitleColor(UIColor.red, for: .normal)
        
        currentLocation.translatesAutoresizingMaskIntoConstraints = false
        zoom.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(currentLocation)
        view.addSubview(zoom)
        
        currentLocation.addTarget(self, action: #selector(showCurrentLocation), for: .touchUpInside)
        zoom.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        
        // 버튼에 대한 제약조건 설정
        currentLocation.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        currentLocation.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        zoom.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        zoom.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        // 핀 추가
        let birthAnnotation = MKPointAnnotation()
        birthAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.101937, longitude: 128.383207)
        birthAnnotation.title = "태어난 곳"
        
        let funAnnotation = MKPointAnnotation()
        funAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.794876, longitude: 127.526743)
        funAnnotation.title = "흥미로운 곳"
        
        mapView.addAnnotation(birthAnnotation)
        print(mapView.annotations)
        mapView.addAnnotation(funAnnotation)
        print(mapView.annotations)
        
        rotatePin = UIButton()
        rotatePin.setTitle("핀 순회", for: .normal)
        rotatePin.setTitleColor(UIColor.green, for: .normal)
        rotatePin.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(rotatePin)
        
        rotatePin.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rotatePin.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        rotatePin.addTarget(self, action: #selector(rotatePinFunc), for: .touchUpInside)
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        // super의 viewDidLoad 구현을 항상 호출한다
        super.viewDidLoad()
        print(mapView.annotations)
        print("MapViewController loaded its view")
    }
    
    // 현재 위치 표시
    
    var locationManager: CLLocationManager!
    
    func showCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        return
    }
    
    func zoomIn() {
        guard let location = locationManager.location else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        mapView.setRegion(region, animated: true)
        print(location)
        
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        currentAnnotation.title = "현재 있는 곳"
        mapView.addAnnotation(currentAnnotation)
        print(mapView.annotations)
    }
    
    var index = 0
    func rotatePinFunc() {
        mapView.selectAnnotation(self.mapView.annotations[index], animated: true)
        print(mapView.annotations)
        index = (index + 1) % mapView.annotations.count
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
    
}
