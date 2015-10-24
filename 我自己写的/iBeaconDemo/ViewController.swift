//
//  ViewController.swift
//  iBeaconDemo
//
//  Created by Massimo on 15/10/22.
//  Copyright © 2015年 Massimo. All rights reserved.
//

import UIKit
import iBeaconModel
let testKey = "testKey"

class ViewController: UIViewController {
  var model : MyModel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 

  private func saveDefaults() {
    let userDefault = NSUserDefaults(suiteName: "group.IBeaconDemo")
    
    userDefault?.setValue(["id":"12345","name":"jack","age":"15","height":"160"], forKey: testKey)
    userDefault?.setValue("1", forKey: "test")

    userDefault!.synchronize()
  }

  private func clearDefaults() {
    let userDefault = NSUserDefaults(suiteName: "group.IBeaconDemo")

    userDefault!.synchronize()

  }

}

