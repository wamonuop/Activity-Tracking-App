//
//  ViewController.swift
//  akillikonumteknolojileri
//
//  Created by Abdullah onur Şimşek on 26.08.2021.
//

import UIKit
import CoreMotion
import CoreLocation
import MapKit
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var m1locationTimer : Timer?
    let manager = CMMotionActivityManager()
    var locationManager : CLLocationManager = CLLocationManager()
    var locationSpeeds : [CLLocationSpeed] = []
    var locationArray : [CLLocation] = []
    var dateArray : [Date] = []
    var m1activityType : String = ""
    var dataArray : [Something] = []
    let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext
    var isMotionAllowed : Bool = true
    var isMotionStarted : Bool = true
    var indexxx : Int = 0
    
    
    
    var counter : Int = 0
    var sender : String = ""
    var activityOpened : Bool = true
    
    
    
    
    let topView : UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "youtube")
        x.layer.shadowColor = UIColor.red.cgColor
        x.layer.shadowRadius = 5
        x.layer.shadowOpacity = 0.3
        x.layer.shadowOffset = CGSize(width: 0, height: 0)
        x.clipsToBounds = false
        return x
    }()
    let greetingsLabel : UILabel = {
        let x = UILabel()
        x.text = "Hello!"
        x.textAlignment = .left
        x.font = UIFont(name: "Lato-Bold", size: 26)
        x.textColor = .white
        return x
    }()
    let activityLabel : UILabel = {
        let x = UILabel()
        x.textAlignment = .left
        x.font = UIFont(name: "Lato-Regular", size: 18)
        x.textColor = .white
        return x
    }()
    let followButton : UIButton = {
        let x = UIButton()
        return x
    }()
    let statusImage : UIImageView = {
        let x = UIImageView()
        x.image = UIImage(named: "locationgray")
        return x
    }()
    let status2Image : UIImageView = {
        let x = UIImageView()
        return x
    }()
    
    
    
    let tableView : UITableView={
        let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        table.backgroundColor = .white
        return table
    }()
    
    
    var strings = ""
    
    
    var number : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        loadItem()
        let count = dataArray.count
        activityLabel.text = "You Completed \(count) activities"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        
        if CMMotionActivityManager.isActivityAvailable(){
            if isMotionAllowed {
                self.manager.startActivityUpdates(to: OperationQueue.main) { (data) in
                    DispatchQueue.main.async {
                        if let activity = data {
                            if activity.running == true && activity.confidence == .high  {
                                self.m1activityType = "Others"
                                if self.isMotionStarted {
                                    self.m1locationTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.getLocation), userInfo: nil, repeats: true)}
                                
                            } else if activity.walking == true && activity.confidence == .high  {
                                self.m1activityType = "Others"
                                if self.isMotionStarted {
                                    self.m1locationTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.getLocation), userInfo: nil, repeats: true)}
                                
                            } else if activity.automotive == true && activity.confidence == .high {
                                self.m1activityType = "Auto"
                                if self.isMotionStarted {
                                    self.m1locationTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.getLocation), userInfo: nil, repeats: true)}
                                
                            } else if activity.cycling == true && activity.confidence == .high {
                                self.m1activityType = "Others"
                                if self.isMotionStarted {
                                    self.m1locationTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.getLocation), userInfo: nil, repeats: true)}
                                
                            }
                        }
                    }
                    
                }
                
            }
            
            
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/5)
        topView.layer.zPosition = 1
        greetingsLabel.frame = CGRect(x: 40, y: 65, width: UIScreen.main.bounds.width-40, height: 34)
        greetingsLabel.layer.zPosition = 1
        activityLabel.frame = CGRect(x: 40, y: greetingsLabel.frame.maxY + 10, width: UIScreen.main.bounds.width - 40, height: 26)
        activityLabel.layer.zPosition = 2
        tableView.frame = CGRect(x: 0, y: topView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-UIScreen.main.bounds.height/5)
        statusImage.frame = CGRect(x:UIScreen.main.bounds.width - 50 , y: 60, width: 25, height: 35)
        statusImage.layer.zPosition = 2
        status2Image.frame = CGRect(x: UIScreen.main.bounds.width-50, y: statusImage.frame.maxY + 10, width: 25, height: 25)
        status2Image.layer.zPosition = 2
        status2Image.isHidden = true
        view.addSubview(topView)
        view.addSubview(greetingsLabel)
        view.addSubview(activityLabel)
        view.addSubview(tableView)
        view.addSubview(statusImage)
        view.addSubview(status2Image)
    }
    
    //MARK:- Core Data and Location Functions
    
    func saveItem(){
        do {
            try context.save()
        } catch {
            print(error)
        }
        loadItem()
    }
    
    func loadItem(){
        let request : NSFetchRequest<Something> = Something.fetchRequest()
        do {
            dataArray = try context.fetch(request)
            if dataArray.isEmpty == false{
                dataArray = dataArray.sorted(by: { $0.dateArray![0].compare($1.dateArray![0]) == .orderedDescending })
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
        let count = dataArray.count
        activityLabel.text = "You Completed \(count) activities"
    }
    
    @objc func getLocation(){
        statusImage.image = UIImage(named: "locationgreen")
        isMotionStarted = false
        var contin : Bool = true
        isMotionAllowed = false
        let date = Date()
        
        if m1activityType == "Others" {
            status2Image.image = UIImage(named: "others")
            status2Image.isHidden = false
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            if let currentLocation = locationManager.location { locationArray.append(currentLocation) ; dateArray.append(date) }
            
            if locationArray.count == 15 {
                let getDistance = locationArray[14].distance(from: locationArray[0])
                var averageSpeed : Double = 0.0
                for index in 0...locationArray.count-1{
                    averageSpeed += locationArray[index].speed
                }
                averageSpeed /= 15
  
                if getDistance < 30 && averageSpeed < 1 {
                    m1locationTimer?.invalidate() ; m1locationTimer = nil ; isMotionAllowed = true ; locationArray = [] ; dateArray = [] ; contin = false ; isMotionStarted = true ; statusImage.image = UIImage(named: "locationgray") ; status2Image.isHidden = true }
            }
            if contin{
                let locationCount : Double = Double(locationArray.count)
                let modal : Double = locationCount.truncatingRemainder(dividingBy: 15)
                if modal == 0 {
                    
                    let lastLocation = locationArray.last
                    let beforeCounting = locationArray[locationArray.count-15]
                    let lastDistance = lastLocation?.distance(from: beforeCounting)
                    let lastSpeed = lastLocation?.speed
                    
                    if lastSpeed! < 0.1 && lastDistance! < 15 {
                        m1locationTimer?.invalidate()
                        m1locationTimer = nil
                        movementStopped()
                    }
                }
                
                
            }
            
        }
        else if m1activityType == "Auto"{
            status2Image.image = UIImage(named: "car")
            status2Image.isHidden = false
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if let currentLocation = locationManager.location { locationArray.append(currentLocation) ; dateArray.append(date) }
            
            if locationArray.count == 10 {
                var averageSpeed : Double = 0.0
                for index in 0...locationArray.count-1{
                    averageSpeed += locationArray[index].speed
                }
                averageSpeed /= 10
                let getDistance = locationArray[9].distance(from: locationArray[0])
                if getDistance < 60 && averageSpeed < 1 {
                    m1locationTimer?.invalidate()
                    m1locationTimer = nil
                    isMotionAllowed = true
                    locationArray = []
                    dateArray = []
                    contin = false
                    isMotionStarted = true
                    statusImage.image = UIImage(named: "locationgray")
                    status2Image.isHidden = true
                }
            }
            
            if contin{
                let locationCount : Double = Double(locationArray.count)
                let modal : Double = locationCount.truncatingRemainder(dividingBy: 45)
                
                if modal == 0 {
                    
                    let lastLocation = locationArray.last
                    let beforeCounting = locationArray[locationArray.count-45]
                    let lastDistance = lastLocation?.distance(from: beforeCounting)
                    let lastSpeed = lastLocation?.speed
                    
                    if lastSpeed! < 1 && lastDistance! < 40 {
                        m1locationTimer?.invalidate()
                        m1locationTimer = nil
                        movementStopped()
                    }
                }
            }
        }
    }
    
    
    func movementStopped(){
        statusImage.image = UIImage(named: "locationgray")
        status2Image.isHidden = true
        
        var lastLocationArray : [CLLocation] = []
        var lastDateArray : [Date] = []
        lastLocationArray.append(locationArray[0])
        lastDateArray.append(dateArray[0])
        var lastLocationCount : Int = 0
        
        
        var distance : Double = 0
        
        if m1activityType == "Auto"{
            distance = 200
        } else {
            distance = 100
        }
        for index in 0...locationArray.count-1{
            if locationArray[index].distance(from: lastLocationArray[lastLocationCount]) >= distance {
                lastLocationArray.append(locationArray[index])
                lastDateArray.append(dateArray[index])
                lastLocationCount += 1
            }
        }
        var totalDistance : Double = 0
        for index in 1...lastLocationArray.count-1 {
            let distance = lastLocationArray[index].distance(from: lastLocationArray[index-1])
            totalDistance +=  distance
        }
        
        lastLocationArray.append(locationArray[locationArray.count-1])
        lastDateArray.append(dateArray[dateArray.count-1])
        
        var newLatitudeArray : [String] = []
        var newLongitudeArray : [String] = []
        var locationSpeeds : [Double] = []
        
        let totalSpeedCount = Double(lastLocationArray.count)
        var totalSpeed : Double = 0
        
        for index in 0...lastLocationArray.count-1{
            totalSpeed += lastLocationArray[index].speed
            let latitude = String(lastLocationArray[index].coordinate.latitude)
            let longitude = String(lastLocationArray[index].coordinate.longitude)
            newLatitudeArray.append(latitude)
            newLongitudeArray.append(longitude)
            locationSpeeds.append(Double(lastLocationArray[index].speed))
            
        }
        
        let averageSpeed = totalSpeed / totalSpeedCount
        
        
        var lastActivity : String = ""
        
        if averageSpeed < 7 {
            lastActivity = "Other"
        } else {
            lastActivity = "Automobile"
        }
        
        
        let newActivity = clientActivity(dateArray: dateArray, activiyType: lastActivity, latitudeArray: newLatitudeArray, longitudeArray: newLongitudeArray, lastPositionLatitude: String(locationArray.last!.coordinate.latitude), lastPositionLongitude: String(locationArray.last!.coordinate.longitude), speeds: locationSpeeds, distanceTravelled: totalDistance, averageSpeed: averageSpeed)
        
        let newToCoreData = Something(context: context)
        
        newToCoreData.activityType = newActivity.activiyType
        newToCoreData.dateArray = newActivity.dateArray
        newToCoreData.lastPositionLatitude = newActivity.lastPositionLatitude
        newToCoreData.lastPositionLongitude = newActivity.lastPositionLongitude
        newToCoreData.latitudeArray = newActivity.latitudeArray
        newToCoreData.longitudeArray = newActivity.longitudeArray
        newToCoreData.startingDate = newActivity.dateArray[0]
        newToCoreData.locationSpeeds = newActivity.speeds
        newToCoreData.distanceTravelled = newActivity.distanceTravelled
        newToCoreData.averageSpeed = newActivity.averageSpeed
        
        saveItem()
        tableView.reloadData()
        loadItem()
        let count = dataArray.count
        activityLabel.text = "You Completed \(count) activities"
        isMotionAllowed = true
        isMotionStarted = true
        
        locationArray = []
        dateArray = []
    }
    
    //MARK:- Segue Operations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as! DataShowViewController
            var newDataArray : [Something] = []
            newDataArray.append(dataArray[indexxx])
            destinationVC.dataArray = newDataArray
            destinationVC.activityNumber = indexxx
            destinationVC.topLabel.text = "\(dataArray.count-indexxx). Activity Details"
            destinationVC.dateArray = dataArray[indexxx].dateArray!
        }
    }
    
    @IBAction func unwindSegueSpotMarketViewController(_ sender: UIStoryboardSegue) {
        
    }
    
    //MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray.isEmpty {
            return 1
        } else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier , for : indexPath) as! TableViewCell
        if dataArray.isEmpty {
            cell.rightImageView.image = UIImage(named: "sex")
            return cell
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let rightDate = dateFormatter.string(from: dataArray[indexPath.row].dateArray![0])
            dateFormatter.dateFormat = "HH:mm"
            let startDate = dateFormatter.string(from: dataArray[indexPath.row].dateArray![0])
            let finishDate = dateFormatter.string(from: dataArray[indexPath.row].dateArray![dataArray[indexPath.row].dateArray!.count-1])
            cell.rightDateLabel.text = rightDate
            cell.activityCount.text = "\(dataArray.count - indexPath.row). Activity"
            cell.activityStartDate.text = startDate
            cell.activityFinishDate.text = finishDate
            let distanceValue = dataArray[indexPath.row].distanceTravelled / 1000
            cell.activityDistance.text = String(format: "%.2f", distanceValue) + " km"
            let speedValue = dataArray[indexPath.row].averageSpeed * 3.6
            cell.activityAverageSpeed.text = String(format: "%.2f", speedValue) + " km/s"
            
            if dataArray[indexPath.row].activityType == "Other"{
                cell.rightImageView.image = UIImage(named: "others")
            } else if dataArray[indexPath.row].activityType == "Automobile"{
                cell.rightImageView.image = UIImage(named: "car")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dataArray.isEmpty{ tableView.deselectRow(at: indexPath, animated: false) ; return}
        else {
            tableView.deselectRow(at: indexPath, animated: false)
            indexxx = indexPath.row
            performSegue(withIdentifier: "toDetailVC", sender: self)
            
        }
    }
    
    
    
}

