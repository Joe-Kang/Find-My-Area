//
//  MapViewControllerDelegate.swift
//  Find My Area
//
//  Created by Jesus Urias on 1/19/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit

protocol MapViewControllerDelegate: class {
    func returnArea(by Controller: MapViewController,_ area:Double, _ name:String)
    func returnDistance(by Controller: MapViewController, _ distance:Double, _ name:String)
}
