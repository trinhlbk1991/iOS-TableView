//
//  ViewController.swift
//  TableView
//
//  Created by East Agile 1b:a8 on 8/3/16.
//  Copyright © 2016 East Agile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let cellIdentifier = "CellIdentifier"
    private var fruits: [String] = []
    private var alphabetizedFruits = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        alphabetizedFruits = alphatizeArray(fruits)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = alphabetizedFruits.keys
        return keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = alphabetizedFruits.keys
        
        // Sort Keys
        let sortedKeys = alphabetizedFruits.keys.sort(compareString)
        
        // Fetch Fruits
        let key = sortedKeys[section]
        
        if let fruits = alphabetizedFruits[key] {
            return fruits.count
        }
        
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sort(compareString)
        
        // Fetch Fruits for Section
        let key = keys[indexPath.section]
        
        if let fruits = alphabetizedFruits[key] {
            // Fetch Fruit
            let fruit = fruits[indexPath.row]
            
            // Configure Cell
            cell.textLabel?.text = fruit
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sort(compareString)
        return keys[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sort(compareString)
        
        // Fetch Fruits for Section
        let key = keys[indexPath.section]
        
        if let fruits = alphabetizedFruits[key] {
            print(fruits[indexPath.row])
        }
    }
    
    private func alphatizeArray(array: [String]) -> [String: [String]] {
        var result = [String: [String]]()
        
        for item in array {
            let index = item.startIndex.advancedBy(1)
            let firstLetter = item.substringToIndex(index).uppercaseString
            
            if result[firstLetter] != nil {
                result[firstLetter]!.append(item)
            } else {
                result[firstLetter] = [item]
            }
        }
        
        for (key, value) in result {
            result[key] = value.sort(compareString)
        }
        
        return result
    }
    
    private func compareString(a: String, b: String) -> Bool {
        return a.lowercaseString < b.lowercaseString
    }
}

