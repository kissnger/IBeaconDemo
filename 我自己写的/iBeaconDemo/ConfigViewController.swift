//
//  ConfigViewController.swift
//  iBeaconDemo
//
//  Created by Massimo on 15/10/22.
//  Copyright © 2015年 Massimo. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
class ConfigViewController: UIViewController {
  @IBOutlet weak var uuid : UILabel!
  @IBOutlet weak var major : UILabel!
  @IBOutlet weak var minor : UILabel!
  @IBOutlet weak var identity : UILabel!


  var beaconRegion         : CLBeaconRegion! //用来设置基站需要的
                                             //proximityUUID ，major和minor 的
                                             //给你信息。

  var beaconPeripheralData : NSDictionary! //用来获取外设的数据

  var peripheralManager    : CBPeripheralManager! //用来开启基站的数据传输。

  override func viewDidLoad() {
    super.viewDidLoad()
    initBeacon()
    setLabels()
    // Do any additional setup after loading the view.
  }

  func initBeacon(){
    let minor = arc4random_uniform(100)

    self.beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "206A2476-D4DB-42F0-BF73-030236F2C756")!, major: 1, minor:UInt16(minor), identifier: "com.K.region")
  }
  func setLabels(){
    self.uuid.text = self.beaconRegion.proximityUUID.UUIDString
    self.major.text = self.beaconRegion.major?.stringValue
    self.minor.text = self.beaconRegion.minor?.stringValue
    self.identity.text = self.beaconRegion.identifier

  }


//  在用户点击了传输按钮之后开始使用设备的蓝牙外设发出信号。方法如下
  @IBAction func transmitAction(sender:UIButton){
    self.beaconPeripheralData = self.beaconRegion.peripheralDataWithMeasuredPower(nil)
    self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)


  }


}
//MARK: - CBPeripheralManagerDelegate
extension ConfigViewController : CBPeripheralManagerDelegate{
  func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {

    if peripheral.state == CBPeripheralManagerState.PoweredOn{
      print("Powered on")
      self.peripheralManager.startAdvertising(self.beaconPeripheralData as? [String:AnyObject])
    }else if peripheral.state == CBPeripheralManagerState.PoweredOff {
      print("Powered off")
      self.peripheralManager.stopAdvertising()
    }
  }
}


















