//
//  ViewController.swift
//  Find My Area
//
//  Created by Jihun Kang on 1/18/18.
//  Copyright © 2018 Jihun Kang. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MapViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func addMapCoordinates(_ sender: UIBarButtonItem) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distanceTableView.dataSource = self
        distanceTableView.delegate = self
        
        areaTableView.dataSource = self
        areaTableView.delegate = self
        print("Hello1")
    }
    
    @IBOutlet weak var distanceTableView: UITableView!
    @IBOutlet weak var areaTableView: UITableView!
    
    var distanceItems = ["living room", "garden", "fences"]
    var areaItems = ["living room", "garden", "fences"]
    
    //    FOR DATABASE
    //    var areas = [AreaItem]()
    //    var distances = [DistanceItem]()
    
    //    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if tableView == self.distanceTableView {
            count = distanceItems.count
            print("DISTANCE ITEMS\(distanceItems.count)")
        }
        if tableView == self.areaTableView {
            count = areaItems.count
        }
        
        return count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if tableView == self.distanceTableView {
            print("Hello2")
            cell = tableView.dequeueReusableCell(withIdentifier: "distanceCell", for: indexPath)
            cell.textLabel?.text = distanceItems[indexPath.row]
        }
        if tableView == self.areaTableView {
            print("Hello3")
            cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath)
            cell.textLabel?.text = areaItems[indexPath.row]
        }
        return cell
    }
    
   
    
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
    
    
    //    FOR DATABASE
    //    func fetchAllItems(){
    //        let areaRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AreaItem")
    //        do {
    //            let areaResult = try managedObjectContext.fetch(areaRequest)
    //            let areaitems = areaResult as! [AreaItem]
    //        } catch {
    //            print("\(error)")
    //        }
    //
    //        let distanceRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DistanceItem")
    //        do {
    //            let distanceResult = try managedObjectContext.fetch(distanceRequest)
    //            let distanceitems = distanceResult as! [DistanceItem]
    //        } catch {
    //            print("\(error)")
    //        }
    //
    //    }
    
    
}





