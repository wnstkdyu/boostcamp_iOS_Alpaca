//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 7. 1..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    @IBOutlet var currentLocationButton: UIButton!
    
    override func loadView() {
        /*
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view.addSubview(mapView)
        
        // 버튼 생성
        currentLocationButton = UIButton()
        currentLocationButton.setTitle("현재 위치", for: .normal)
        
        let margins = view.layoutMarginsGuide
        let buttonBottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 10)
        let buttonTrailingConstraint = currentLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10)
        // 활성화
        buttonBottomConstraint.isActive = true
        buttonTrailingConstraint.isActive = true
        
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        // whiteColor().colorWithAlphaComponent(0.5)에서 변경
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        /* 터치 타겟 설정 */
        segmentedControl.addTarget(self, action: Selector(("mapTypeChanged")), for: .valueChanged)
        
        /* segmentedControl 뷰를 상위 뷰의 위, leading, trailing이 같게 제약조건을 형성 */
        // 변경점 있음
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        /* 상태바 밑에 오도록 topLayoutGuide의 bottomAnchor에 segmentedControl의 topAnchor를 맞춘다 */
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        /*
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        */
        
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        // 활성화
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        */
    }
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
    }
    
    @IBAction func locateCurrentPosition(sender: AnyObject) {
        mapViewWillStartLocatingUser(mapView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        print("MapViewController loaded its view")
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view.addSubview(mapView)
        
        // 버튼 생성
        currentLocationButton = UIButton()
        currentLocationButton.setTitle("현재 위치", for: .normal)
        
        let margins = view.layoutMarginsGuide
        let buttonBottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 10)
        let buttonTrailingConstraint = currentLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10)
        // 활성화
        buttonBottomConstraint.isActive = true
        buttonTrailingConstraint.isActive = true
        
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        // whiteColor().colorWithAlphaComponent(0.5)에서 변경
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        /* 터치 타겟 설정 */
        segmentedControl.addTarget(self, action: Selector(("mapTypeChanged")), for: .valueChanged)
        
        /* segmentedControl 뷰를 상위 뷰의 위, leading, trailing이 같게 제약조건을 형성 */
        // 변경점 있음
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        /* 상태바 밑에 오도록 topLayoutGuide의 bottomAnchor에 segmentedControl의 topAnchor를 맞춘다 */
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        /*
         let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
         let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         */
        
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        // 활성화
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
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
}
