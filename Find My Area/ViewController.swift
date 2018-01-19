//
//  ViewController.swift
//  Find My Area
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, MapViewControllerDelegate {
    @IBAction func addMapCoordinates(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}

    func returnArea(by Controller: UIViewController, _ area: Double) {
        dismiss(animated: true, completion: nil)
        print(area)

    }
    
    func returnDistance(by Controller: UIViewController, _ distance: Double) {
        dismiss(animated: true, completion: nil)
        print(distance)

    }
    
    

}

