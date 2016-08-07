//
//  MoodViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var moodCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
        moodCollectionView.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    var progressHUD = MBProgressHUD()
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Item \(indexPath.item) Selected")
        let cell = collectionView.cellForItemAtIndexPath(indexPath);
        
        progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.mode = .Indeterminate
        progressHUD.label.text = "Playing Music"
        progressHUD.color = UIColor(white: 1.0, alpha: 1.0)
        progressHUD.label.textColor = UIColor.darkGrayColor()
        progressHUD.detailsLabel.text = ""
        progressHUD.detailsLabel.textColor = UIColor.darkGrayColor()
        progressHUD.activityIndicatorColor = UIColor.darkGrayColor()
        progressHUD.dimBackground = true
   
        
        if cell!.tag == 1 { // happy
            progressHUD.detailsLabel.text = "Happy!😃"
            APIMagic().playPlaylist("spotify:user:1249991492:playlist:6jfh1sX0fX06rwYNmjbBKt") {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        } else if cell!.tag == 2 { // excited
            progressHUD.detailsLabel.text = "Excited!! 🤗"
            APIMagic().playPlaylist("spotify:user:1249991492:playlist:3uI1toPZXVhmLprsGXQFkV") {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        } else if cell!.tag == 3 { // angry
            progressHUD.detailsLabel.text = "Angry 😡"
            APIMagic().playPlaylist("spotify:user:1249991492:playlist:3M6etJu6FIaZgB7WYTxa8j") {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }
        } else { // sad
            progressHUD.detailsLabel.text = "Sad 😭"
            APIMagic().playPlaylist("spotify:user:1249991492:playlist:1cxBlGujdByoiMyANqeUqN") {
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }

        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoodCell", forIndexPath: indexPath) as! MoodCollectionViewCell
        cell.tag = indexPath.item
        cell.layer.cornerRadius = 5
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.shadowColor = UIColor.blackColor().CGColor
//        cell.layer.shadowOffset = CGSizeMake(5, 5)
//        cell.layer.shadowRadius = 10
        cell.backgroundColor = nil
        cell.backgroundView = nil
        
        
        switch indexPath.item % 4 {
        case 0:
            cell.tag = 1
            cell.moodMonsterImage.image = UIImage(named: "happy")
        case 1:
            cell.tag = 2
            cell.moodMonsterImage.image = UIImage(named: "excited")
        case 2:
            cell.tag = 3
            cell.moodMonsterImage.image = UIImage(named: "angry")
        case 3:
            cell.tag = 4
            cell.moodMonsterImage.image = UIImage(named: "sad")
        default:
            cell.moodMonsterImage.image = UIImage(named: "happy")
        }
        
        
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
