//
//  MainSideViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class MainSideViewController: UIViewController {

    struct Navigation {
        static let AudioSelected = "AudioSelected"
        static let VideoSelected = "VideoSelected"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func audioTabButtonClicked(sender: AnyObject) {
        postNotification(0)
    
    }
    
    @IBAction func videoTabButtonClicked(sender: AnyObject) {
        postNotification(1)
        
    }
    
    func postNotification(index: Int){
        let notificationCenter = NSNotificationCenter.defaultCenter()
        switch index {
        case 0:
            notificationCenter.postNotification(NSNotification(name: Navigation.AudioSelected, object: self))
        case 1:
            notificationCenter.postNotification(NSNotification(name: Navigation.VideoSelected, object: self))
        default:
            break
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
