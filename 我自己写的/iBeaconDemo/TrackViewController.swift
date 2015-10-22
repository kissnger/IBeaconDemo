//
//  TrackViewController.swift
//  iBeaconDemo
//
//  Created by Massimo on 15/10/22.
//  Copyright © 2015年 Massimo. All rights reserved.
//

import UIKit
import CoreLocation
class TrackViewController: UIViewController {
  @IBOutlet weak var welcomeIBeacon : UILabel!
  @IBOutlet weak var uuid : UILabel!
  @IBOutlet weak var major : UILabel!
  @IBOutlet weak var minor : UILabel!
  @IBOutlet weak var accuracy : UILabel!
  @IBOutlet weak var distance : UILabel!
  @IBOutlet weak var rssi : UILabel!
  @IBOutlet weak var count : UILabel!

  var beaconRegion : CLBeaconRegion!
  let trackLacationManager : CLLocationManager! = CLLocationManager()


  override func viewDidLoad() {
    super.viewDidLoad()
     // Do any additional setup after loading the view.

    self.trackLacationManager.delegate = self
    self.trackLacationManager.requestAlwaysAuthorization()

    self.initRegion()
//     self.locationManager(self.trackLacationManager, didStartMonitoringForRegion: self.beaconRegion)

  }

  func initRegion(){
     self.beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "206A2476-D4DB-42F0-BF73-030236F2C756")!, identifier: "com.K.region")
    self.trackLacationManager.startMonitoringForRegion(self.beaconRegion)
  }


}


extension TrackViewController: CLLocationManagerDelegate{
  func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
    self.trackLacationManager.startRangingBeaconsInRegion(self.beaconRegion)
  }

  func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    self.trackLacationManager.startRangingBeaconsInRegion(self.beaconRegion)
  }

  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    self.trackLacationManager.stopRangingBeaconsInRegion(self.beaconRegion)
    self.welcomeIBeacon.text = "NO"
  }

  func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
    
    print("beacons count" + String(beacons.count))

    if beacons.count <= 0 {
      return
    }

    let beacon: CLBeacon? = beacons.first

    self.welcomeIBeacon.text = "Yes"
    self.uuid.text = beacon?.proximityUUID.UUIDString
    self.major.text = beacon?.major.stringValue
    self.minor.text = beacon?.minor.stringValue
    self.accuracy.text = "\(beacon!.accuracy)"

    if (beacon?.proximity != nil) {
      switch(beacon!.proximity){
      case .Unknown:
          self.distance.text = "Immediate"
      case CLProximity.Immediate:
        self.distance.text = ""
      case CLProximity.Near:
        self.distance.text = "Near"
      case CLProximity.Far:
        self.distance.text = "Far"
      }
    }
    
    self.rssi.text = beacon?.rssi.description

    self.count.text = "\(beacons.count)"



  }



}













