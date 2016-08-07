//
//  RootAudioViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class RootAudioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var songTableView: UITableView!
    
    
    @IBOutlet weak var searchBarField: UITextField!
    
    @IBOutlet weak var searchBarIconImage: UIImageView!
    
    @IBOutlet weak var songPlayerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.620, green: 0.353, blue: 0.545, alpha: 1.00)
        songTableView.separatorStyle = .None
        songTableView.dataSource = self
        songTableView.delegate   = self
        songTableView.backgroundColor = nil
        
        self.searchBarField.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Search Bar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Searching for  \(textField.text!)")
        
        APIMagic().searchSpotify("\(textField.text!)") { (results) in
            //            print(results)
            
            self.songDictioniaries = [[String:AnyObject]](count: results.count, repeatedValue: [String:AnyObject]())
            
            for index in 0..<results.count{
                //                print(results[index]["track"]["artist_name"].string!)
                var storeDictionary = [String:AnyObject]()
                storeDictionary["songArtist"] = results[index]["track"]["artist_name"].string!
                storeDictionary["songTitle"] = results[index]["track"]["track_name"].string!
                print("\(storeDictionary)")
                self.songDictioniaries[index] = storeDictionary
            }
            
            self.songTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            
        }
        
        return true
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        textField.layoutIfNeeded()
        UIView.animateWithDuration(0.6) {
            self.searchBarIconImage.alpha = 0.0
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField.text == ""{
            UIView.animateWithDuration(0.6) {
                self.searchBarIconImage.alpha = 1.0
            }
        }else{
            
        }
    }
    
    //MARK: - Table View Delegate/Data Source
    
    var songDictioniaries = [[String:AnyObject]]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songDictioniaries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.songTableView.dequeueReusableCellWithIdentifier("SongCell") as! SongTableViewCell
        cell.backgroundColor = nil
        cell.backgroundView = nil
        cell.contentView.backgroundColor = nil
        if indexPath.row % 2 == 0{
            //            cell.contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }else{
            //            cell.contentView.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
            cell.contentView.backgroundColor = UIColor(red: 0.941, green: 0.945, blue: 0.961, alpha: 1.00)
        }
        cell.songNumberLabel.text = "\(indexPath.row + 1)"
        
        cell.songTitleLabel.text = songDictioniaries[indexPath.row]["songTitle"] as! String
        cell.songArtistLabel.text = songDictioniaries[indexPath.row]["songArtist"] as! String
        let backgroundSelected = UIView(frame: CGRectMake(0,0, cell.frame.width, 80))
        backgroundSelected.backgroundColor = UIColor(red: 0.980, green: 0.867, blue: 0.553, alpha: 1.00)
        cell.selectedBackgroundView = backgroundSelected
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        UIView.animateWithDuration(1.0) { 
            self.songPlayerBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
