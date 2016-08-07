//
//  RootAudioViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class RootAudioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var songTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        songTableView.separatorStyle = .None
        songTableView.dataSource = self
        songTableView.delegate   = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Table View Delegate/Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.songTableView.dequeueReusableCellWithIdentifier("SongCell") as! SongTableViewCell
        
        cell.contentView.backgroundColor = nil
        if indexPath.row % 2 == 0{
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }else{
            cell.contentView.backgroundColor = UIColor(red: 0.941, green: 0.945, blue: 0.961, alpha: 1.00)
        }
        cell.songNumberLabel.text = "\(indexPath.row + 1)"
        
        switch indexPath.row {
        case 0:
            cell.songTitleLabel.text = "Levels"
            cell.songArtistLabel.text = "Avicii"
        case 1:
            cell.songTitleLabel.text = "Airplanes, Part II"
            cell.songArtistLabel.text = "B.o.B feat Eminem"
        case 2:
            cell.songTitleLabel.text = "Sandstorm"
            cell.songArtistLabel.text = "Darude"
        case 3:
            cell.songTitleLabel.text = "Falling (Wheathin Remix)"
            cell.songArtistLabel.text = "Opia"
        case 4:
            cell.songTitleLabel.text = "Show Me Love (Big Wild Remix)"
            cell.songArtistLabel.text = "Hundred Waters"
        case 5:
            cell.songTitleLabel.text = "Mr. Watson (BKAYE Remix)"
            cell.songArtistLabel.text = "Cruel Youth"
        case 6:
            cell.songTitleLabel.text = "Dreams"
            cell.songArtistLabel.text = "Joakim Karud"
        case 7:
            cell.songTitleLabel.text = "Gekko"
            cell.songArtistLabel.text = "Oliver Heldens"
        case 8:
            cell.songTitleLabel.text = "You & Me"
            cell.songArtistLabel.text = "Flume"
        case 9:
            cell.songTitleLabel.text = "Some"
            cell.songArtistLabel.text = "Ahn Jung Jae & Sungha Jung"
        default:
            cell.songTitleLabel.text = "Gekko"
            cell.songArtistLabel.text = "Oliver Heldens"
        }
        let backgroundSelected = UIView(frame: CGRectMake(0,0, cell.frame.width, 80))
        backgroundSelected.backgroundColor = UIColor(red: 0.980, green: 0.867, blue: 0.553, alpha: 1.00)
        cell.selectedBackgroundView = backgroundSelected
        
        return cell
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
