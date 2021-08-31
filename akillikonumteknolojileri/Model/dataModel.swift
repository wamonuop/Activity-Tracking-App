//
//  dataModel.swift
//  akillikonumteknolojileri
//
//  Created by Abdullah onur Şimşek on 28.08.2021.
//

import Foundation

struct clientActivity {
    var dateArray : [Date]
    var activiyType : String
    var latitudeArray : [String]
    var longitudeArray : [String]
    var lastPositionLatitude : String
    var lastPositionLongitude : String
    var speeds : [Double]
    var distanceTravelled : Double
    var averageSpeed : Double
}
