# alpaca's 코딩 스타일


- K & R (Stroustrup)

```swift
if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
```

- 비슷한 것끼리 모아둔다.

```swift
        let birthAnnotation = MKPointAnnotation()
        birthAnnotation.coordinate = CLLocationCoordinate2D(latitude: 36.101937, longitude: 128.383207)
        birthAnnotation.title = "태어난 곳"
        
        let funAnnotation = MKPointAnnotation()
        funAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.794876, longitude: 127.526743)
        funAnnotation.title = "흥미로운 곳"
```
- 함수 시작할 때, 끝날 때 굳이 빈 줄을 만들지 않는다.

```swift
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
```
- 연산자는 띄어쓰기를 기본으로 하지만 붙여쓰는게 가독성이 좋을 경우 붙여 쓴다.

```swift
return (value - 32) * (5/9)
```

- , : 같은 경우 앞에는 붙여 쓰고 뒤에는 띄어 쓴다.

```swift
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
...
}
```
- 주석은 자주 쓰려고 노력하며 // 이후 한번 띄고 쓴다.

```swift
override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
}
```

