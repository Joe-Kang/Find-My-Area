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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let mapViewController = navigationController.topViewController as! MapViewController
        mapViewController.delegate = self
    }

    func returnArea(by Controller: MapViewController, _ area: Double) {
        dismiss(animated: true, completion: nil)
        print(area)

    }

    func returnDistance(by Controller: MapViewController, _ distance: Double) {
        dismiss(animated: true, completion: nil)
        print(distance)
    }
}

