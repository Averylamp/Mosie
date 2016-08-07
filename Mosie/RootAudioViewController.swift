//
//  RootAudioViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit
import MBProgressHUD

class RootAudioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    @IBOutlet weak var songTableView: UITableView!
    
    @IBOutlet weak var cleanOnlySwitch: UISwitch!
    
    @IBOutlet weak var searchBarField: UITextField!
    
    @IBOutlet weak var searchBarIconImage: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    
    @IBOutlet weak var songArtistLabel: UILabel!
    @IBOutlet weak var songPlayerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 1.000, green: 0.992, blue: 0.965, alpha: 1.00)
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
    var progressHUD = MBProgressHUD()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Searching for  \(textField.text!)")
        
        progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.mode = .Indeterminate
        progressHUD.label.text = "Searching for \(textField.text!)"
        progressHUD.color = UIColor(white: 1.0, alpha: 1.0)
        progressHUD.label.textColor = UIColor.darkGrayColor()
        progressHUD.detailsLabel.text = ""
        progressHUD.detailsLabel.textColor = UIColor.darkGrayColor()
        progressHUD.activityIndicatorColor = UIColor.darkGrayColor()
        progressHUD.dimBackground = true
        
        
        let api = APIMagic();
        api.searchSpotify(textField.text!) { (results) in
            self.songDictioniariesAll = [[String:AnyObject]]()
            self.songDictioniariesClean = [[String:AnyObject]]()
            self.delay(0.5, closure: {
                self.progressHUD.detailsLabel.text = "\(results.count) songs found"
            })
            
            self.delay(1.5, closure: {
                self.progressHUD.detailsLabel.text = "Checking Lyrics"
                
            })
            var activeConnections = 0
            for index in 0..<results.count{
                let lyrics_id:String = String(results[0]["track"]["track_id"].number as! Int)
//                                print(results[index])
                var storeDictionary = [String:AnyObject]()
                storeDictionary["songArtist"] = results[index]["track"]["artist_name"].string!
                storeDictionary["songTitle"] = results[index]["track"]["track_name"].string!
                storeDictionary["spotifyURI"] = results[index]["track"]["track_spotify_id"].string!
//                print("\(storeDictionary)")
                
                activeConnections += 1
                api.getLyrics(lyrics_id) { (lyrics) in
                    print(lyrics)
                    let naughtyResults = api.isNaughty(lyrics)
                    print("Naughty: \(naughtyResults)")
                    storeDictionary["naughty_results"] = naughtyResults
                    if naughtyResults == nil{
                        print("clean song")
                        self.songDictioniariesClean.append(storeDictionary)
                    }
                    self.songDictioniariesAll.append(storeDictionary)
//                    api.playSong(results[0]["track"]["track_spotify_id"].string!);
                    activeConnections -= 1
                    if activeConnections == 0 {
                        if self.cleanOnlySwitch.on {
                            self.activeDictionary = self.songDictioniariesClean
                        }else{
                            self.activeDictionary = self.songDictioniariesAll
                        }
                        print("Reloading Table")
                        self.songTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                        self.progressHUD.detailsLabel.text = "Done!"
                        self.delay(0.5, closure: {
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        })
                    }
                    
                }
            }
            
        }
        return true
    }
    
    @IBAction func cleanSwitchChanged(sender: AnyObject) {
        if self.cleanOnlySwitch.on {
            self.activeDictionary = self.songDictioniariesClean
        }else{
            self.activeDictionary = self.songDictioniariesAll
        }
        self.songTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        
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
    
    var songDictioniariesAll = [[String:AnyObject]]()
    var songDictioniariesClean = [[String:AnyObject]]()
    var activeDictionary = [[String:AnyObject]]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeDictionary.count
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
        
        cell.songTitleLabel.text = activeDictionary[indexPath.row]["songTitle"] as! String
        cell.songArtistLabel.text = activeDictionary[indexPath.row]["songArtist"] as! String
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
        self.songTitleLabel.text = activeDictionary[indexPath.row]["songTitle"] as! String
        self.songArtistLabel.text = activeDictionary[indexPath.row]["songArtist"] as! String
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
