//
//  DataShowViewController.swift
//  akillikonumteknolojileri
//
//  Created by Abdullah onur Şimşek on 28.08.2021.
//

import UIKit
import CoreLocation
import MapKit



class DataShowViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let backButton : UIButton = {
       let x = UIButton()
        x.setImage(UIImage(named: "backward"), for: .normal)
        x.imageView?.contentMode = .scaleToFill
        x.tintColor = .white
       return x
    }()
    
    let secondMapView : MKMapView = {
        let x = MKMapView()
        return x
    }()
    
    let topView : UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "youtube")
        return x
    }()
    
    let topLabel : UILabel = {
       let x = UILabel()
        x.text = "your...activity"
        x.textColor = .white
        x.font = UIFont(name: "Lato-Bold", size: 30)
        x.textAlignment = .left
        x.textColor = .white
       return x
    }()
    let scrollView : UIScrollView = {
       let x = UIScrollView()
       return x
    }()
    
    let activityTypeLabel : UILabel = {
       let x = UILabel()
        x.textColor = .lightGray
        x.font = UIFont(name: "Lato-Regular", size: 22)
        x.textAlignment = .left
        x.text = "Activity Type"
       return x
    }()
    let activityType : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 28)
        x.textAlignment = .left
       return x
    }()
    let activityStartDateLabel : UILabel = {
       let x = UILabel()
        x.textColor = .lightGray
        x.font = UIFont(name: "Lato-Regular", size: 22)
        x.textAlignment = .left
        x.text = "Started At"
       return x
    }()
    let activityStartDate : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 28)
        x.textAlignment = .left
       return x
    }()
    let activityFinishDateLabel : UILabel = {
       let x = UILabel()
        x.textColor = .lightGray
        x.font = UIFont(name: "Lato-Regular", size: 22)
        x.textAlignment = .left
        x.text = "Finished At"
       return x
    }()
    let activityFinishDate : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 28)
        x.textAlignment = .left
       return x
    }()
    let activityAverageSpeedLabel : UILabel = {
       let x = UILabel()
        x.textColor = .lightGray
        x.font = UIFont(name: "Lato-Regular", size: 22)
        x.textAlignment = .left
        x.text = "Average Speed"
       return x
    }()
    let activityAverageSpeed : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 28)
        x.textAlignment = .left
       return x
    }()
    let activityEstimatedDistanceLabel : UILabel = {
       let x = UILabel()
        x.textColor = .lightGray
        x.font = UIFont(name: "Lato-Regular", size: 22)
        x.textAlignment = .left
        x.text = "Estimated Distance"
       return x
    }()
    let activityEstimatedDistance : UILabel = {
       let x = UILabel()
        x.textColor = .darkGray
        x.font = UIFont(name: "Lato-Bold", size: 28)
        x.textAlignment = .left
       return x
    }()
    
    var dataArray : [Something] = []
    var dateArray : [Date] = []
    
    var activityNumber : Int = 0
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
             overrideUserInterfaceStyle = .light
         }
        secondMapView.delegate = self
        topView.isUserInteractionEnabled = true
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        createSomething()
    }
    
    override func viewDidLayoutSubviews() {
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
        topView.addSubview(topLabel)
        topView.addSubview(backButton)
        topLabel.frame = CGRect(x: 60, y: 60, width: 400, height: 36)
        scrollView.frame = CGRect(x: 0, y: topView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - UIScreen.main.bounds.height / 8)
        
        scrollView.backgroundColor = .clear
        
        scrollView.addSubview(secondMapView)
        scrollView.addSubview(activityTypeLabel)
        scrollView.addSubview(activityType)
        scrollView.addSubview(activityStartDateLabel)
        scrollView.addSubview(activityStartDate)
        scrollView.addSubview(activityFinishDateLabel)
        scrollView.addSubview(activityFinishDate)
        scrollView.addSubview(activityAverageSpeedLabel)
        scrollView.addSubview(activityAverageSpeed)
        scrollView.addSubview(activityEstimatedDistanceLabel)
        scrollView.addSubview(activityEstimatedDistance)

        
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        
        secondMapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width + 200)
        let width = UIScreen.main.bounds.width
        let everyX : CGFloat = 50
        activityTypeLabel.frame = CGRect(x: everyX, y: secondMapView.frame.maxY + 30, width: width, height: 30)
        activityType.frame = CGRect(x: everyX, y: activityTypeLabel.frame.maxY + 5, width: width, height: 30)
        activityStartDateLabel.frame = CGRect(x: everyX, y: activityType.frame.maxY + 5, width: width, height: 30)
        activityStartDate.frame = CGRect(x: everyX, y: activityStartDateLabel.frame.maxY + 5, width: width, height: 30)
        activityFinishDateLabel.frame = CGRect(x: everyX, y: activityStartDate.frame.maxY + 5, width: width, height: 30)
        activityFinishDate.frame = CGRect(x: everyX, y: activityFinishDateLabel.frame.maxY + 5, width: width, height: 30)
        activityAverageSpeedLabel.frame = CGRect(x: everyX, y: activityFinishDate.frame.maxY + 5, width: width, height: 30)
        activityAverageSpeed.frame = CGRect(x: everyX, y: activityAverageSpeedLabel.frame.maxY + 5, width: width, height: 30)
        activityEstimatedDistanceLabel.frame = CGRect(x: everyX, y: activityAverageSpeed.frame.maxY + 5, width: width, height: 30)
        activityEstimatedDistance.frame = CGRect(x: everyX, y: activityEstimatedDistanceLabel.frame.maxY + 5, width: width, height: 30)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: activityEstimatedDistance.frame.maxY + 20)
        
        backButton.frame = CGRect(x: 15, y: 64, width: 28, height: 28)
        view.addSubview(topView)
        view.addSubview(scrollView)
    }
    

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay.isKind(of: MKPolyline.self){
            let polylinerenderer = MKPolylineRenderer(overlay: overlay)
            polylinerenderer.fillColor = #colorLiteral(red: 0.3333333333, green: 0.431372549, blue: 0.3254901961, alpha: 1)
            polylinerenderer.strokeColor = #colorLiteral(red: 0.3333333333, green: 0.431372549, blue: 0.3254901961, alpha: 1)
            polylinerenderer.lineWidth = 5
            return polylinerenderer
        } else if overlay.isKind(of: MKMultiPolyline.self){
            let polylinerenderer = MKMultiPolylineRenderer(overlay: overlay)
            polylinerenderer.fillColor = #colorLiteral(red: 0.3333333333, green: 0.431372549, blue: 0.3254901961, alpha: 1)
            polylinerenderer.strokeColor = #colorLiteral(red: 0.3333333333, green: 0.431372549, blue: 0.3254901961, alpha: 1)
            polylinerenderer.lineWidth = 5
            return polylinerenderer
        }
        return MKOverlayRenderer(overlay: overlay)
   }

    @objc func backButtonPressed(){
        self.performSegue(withIdentifier: "somethingsomething", sender: self)
    }
    
    func createSomething(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let date1 = dateFormatter.string(from: dateArray[0])
        let date2 = dateFormatter.string(from: dateArray[dateArray.count-1])
        activityType.text = dataArray[0].activityType
        activityStartDate.text = date1
        activityFinishDate.text = date2
        let averageSpeed = Int(dataArray[0].averageSpeed*3.6)
        activityAverageSpeed.text = "\(averageSpeed) km/s"
        let distance = dataArray[0].distanceTravelled / 1000
        let distanceString = String(format: "%.2f", distance)
        activityEstimatedDistance.text = "\(distanceString) km"
        
        
        var locationArray : [CLLocationCoordinate2D] = []
        var pointArray : [MKMapPoint] = []
        
        if dataArray.isEmpty{
            return
        } else {
            for index in 0...dataArray[0].longitudeArray!.count-1{
                let annotation = MKPointAnnotation()
                annotation.title = "\(index). Point"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let datex = dateFormatter.string(from: dateArray[index])
                annotation.subtitle = "\(datex)"
                let newLatitude = CLLocationDegrees((dataArray[0].latitudeArray![index] as NSString).doubleValue)
                let newLongitude = CLLocationDegrees((dataArray[0].longitudeArray![index] as NSString).doubleValue)
                let newLocation = CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)
                let point = MKMapPoint(newLocation)
                pointArray.append(point)
                annotation.coordinate = newLocation
                locationArray.append(newLocation)
                secondMapView.addAnnotation(annotation)
            }
        }
        
        if locationArray.isEmpty{
            return
        } else {
            let mypolyline = MKPolyline(coordinates: locationArray, count: locationArray.count)
            secondMapView.addOverlay(mypolyline, level: .aboveRoads)
            let span = MKCoordinateSpan(latitudeDelta: 0.0475, longitudeDelta: 0.0475)
            let region = MKCoordinateRegion(center: locationArray[(locationArray.count-1)/2], span: span)
            secondMapView.setRegion(region, animated: true)

            var polyar : [MKPolyline] = []
            for index in 1...locationArray.count-1{
                
                let sourceLocation = locationArray[index-1]
                let destinationLocation = locationArray[index]
                let polyline = MKPolyline(coordinates: [sourceLocation,destinationLocation], count: 2)
                polyar.append(polyline)
            }
            }
        }
        
    }


