//
//  MapViewControllerDelegate.swift
//  Find My Area
//
//  Created by Jesus Urias on 1/19/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit

protocol MapViewControllerDelegate {
    func returnArea(by Controller: UIViewController,_ area:Double)
    func returnDistance(by Controller: UIViewController, _ distance:Double)
}
