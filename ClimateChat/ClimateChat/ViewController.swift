//
//  ViewController.swift
//  ClimateChat
//
//  Created by Kelly Yamamoto on 10/13/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var onMessage: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var names = ["Nick","Lindsey","Jason","Kevin","Muddassar","Matthew","Cameron","Tracey"]
    
    var content = ["Let's be engineers", "Did you just put that label under the other label?","What did you have for breakfast?", "banana bread", "smoothie", "breakfast?", "eggs"]
    
    var messages =
        [
            ["name":"Nick", "content":"Let's be engineers!"],
            ["name":"Lindsey", "content":"Did you just put that label under the other label?"],
            ["name":"Jason","content":"What did you have for breakfast?"],
            ["name":"Kevin","content":"banana bread"],
            ["name": "Muddassar", "content": "smoothie"],
            ["name":"Matthew","content":"breakfast?"],
            ["name":"Cameron",  "content":],
            ["name":"Tracey", "content":"eggs"]
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

}
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return messages.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
        
        var messageDictionary = messages[indexPath.row]
        
        cell.contentLabel.text = messageDictionary["content"]
        
        cell.nameLabel.text = messageDictionary["name"]

        
        print("row: \(indexPath.row)")
        return cell
}