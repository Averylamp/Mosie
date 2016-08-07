//
//  RootVideoViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit
import YoutubeEngine
import Alamofire
import SDWebImage

class RootVideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var videoTableView: UITableView!
    
    @IBOutlet weak var videoSearchTextField: UITextField!
    
    @IBOutlet weak var searchText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.backgroundColor = nil
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.separatorStyle = .None
        self.view.backgroundColor = UIColor(rgba: "#F5C3230A")
        videoSearchTextField.delegate = self
        
<<<<<<< HEAD
        let engine = Engine(key: "AIzaSyCgwWIve2NhQOb5IHMdXxDaRHOnDrLdrLg")
        let request = Search(.Term("VEVO", [.Video: [.Statistics, .ContentDetails], .Channel: [.Statistics]]))
        engine.search(request)
            .startWithNext {
                page in
                let formattedItems = page.items.enumerate().map { "[\($0)] = \($1)" }
               // print("VEVO:\n\(formattedItems.joinWithSeparator("\n"))")
        }

=======
//        youtubeEngine = Engine(key: "AIzaSyCgwWIve2NhQOb5IHMdXxDaRHOnDrLdrLg")
//
//
//        let youtubeAuth = BAHYouTubeOAuth()
//        youtubeAuth.authenticateWithYouTubeUsingYouTubeClientID("486857137228-u7067h82gkgfcjl6pnc8bc9a7l4s888v.apps.googleusercontent.com", youTubeClientSecret: "", responseType: <#T##String!#>, scope: <#T##String!#>, state: <#T##String!#>, appURLCallBack: <#T##String!#>, accessType: <#T##String!#>, viewController: <#T##AnyObject!#>, <#T##completelion: ((Bool, String!, String!) -> Void)!##((Bool, String!, String!) -> Void)!##(Bool, String!, String!) -> Void#>)
//        
>>>>>>> origin/master
        // Do any additional setup after loading the view.
    }
    
    
    func searchForVideo(searchTerm: String){
        let query = searchTerm.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let queryURL = "https://www.googleapis.com/youtube/v3/search?part=id%2Csnippet&maxResults=20&q=\(query)&type=video&videoCaption=closedCaption&key=AIzaSyDvCC8cOyjDpQsfXoNKqgpgPUaMyaSq6ZQ"
        print(queryURL)
        Alamofire.request(.GET, queryURL).responseJSON { (response) in
            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
            print(response.result)   // result of response serialization
            if response.data != nil{
                let json = JSON(data:response.data!)
//                print("JSON: \(json)")
//                print(json["items"])
                self.videoData = [[String:AnyObject]](count:json["items"].array!.count, repeatedValue:[String:AnyObject]())
                for itemNum in 0..<json["items"].array!.count{
                    let videoDictionary = json["items"][itemNum].dictionary!
                    var storeDictionary = [String:AnyObject]()
                    storeDictionary["title"] = videoDictionary["snippet"]!["title"].string!
                    storeDictionary["channel"] = videoDictionary["snippet"]!["channelTitle"].string!
                    storeDictionary["id"] = videoDictionary["id"]!["videoId"].string!
                    storeDictionary["thumbURL"] = videoDictionary["snippet"]!["thumbnails"]["high"]["url"].string!
                    self.videoData[itemNum] = storeDictionary
                }
                
                self.videoTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            }

        }
    }
    
    
    //shadow, (4,4) 10 rad

    @IBOutlet weak var searchImage: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Search Delegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.6) {
            self.searchImage.alpha = 0.0
            self.searchText.alpha = 0.0
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == ""{
            UIView.animateWithDuration(1.0, animations: { 
                self.searchImage.alpha = 1.0
                if self.videoData.count == 0{
                    self.searchText.alpha = 1.0
                }
                
            })
        }else{
            searchForVideo(textField.text!)
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Table View Data Source
    
    var videoData = [[String: AnyObject]]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoData.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath) as! VideoTableViewCell
        cell.backgroundColor = nil
        cell.containerView.layer.shadowOpacity = 0.5
        cell.containerView.layer.shadowRadius = 5
        cell.containerView.layer.shadowOffset = CGSizeMake(3, 3)
        
        
        cell.videoTitleLabel.text = videoData[indexPath.row]["title"] as? String
        cell.videoChannelLabel.text = videoData[indexPath.row]["channel"] as? String
        
        let url = videoData[indexPath.row]["thumbURL"] as? String
        let nsurl = NSURL(string: url!)
        SDWebImageDownloader.sharedDownloader().downloadImageWithURL(nsurl, options: SDWebImageDownloaderOptions.LowPriority, progress: nil) { (image, data, error, finished) in
            cell.videoImageThumbnail.image = image
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let playVC = UIStoryboard(name: "VideoStoryboard", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("VideoPlayVC")
        
        self.navigationController?.pushViewController(playVC, animated: true)
        
        
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
