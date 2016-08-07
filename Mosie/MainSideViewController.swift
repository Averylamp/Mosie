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
        static let SettingsSelected = "SettingsSelected"
        static let MoodSelected = "MoodSelected"
    }
    
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var moodButton: UIButton!
    
    @IBOutlet var tabMenuButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoButton.layer.cornerRadius = videoButton.frame.width / 2
        audioButton.layer.cornerRadius = audioButton.frame.width / 2
        settingsButton.layer.cornerRadius = settingsButton.frame.width / 2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func audioTabButtonClicked(sender: AnyObject) {
        postNotification(0)
        tabMenuButtons.forEach { $0.alpha = 1.0 }
        audioButton.alpha = 0.6
    }
    
    @IBAction func videoTabButtonClicked(sender: AnyObject) {
        postNotification(1)
        tabMenuButtons.forEach { $0.alpha = 1.0 }
        videoButton.alpha = 0.6
    }
    
    @IBAction func settingsTabButtonClicked(sender: AnyObject) {
        postNotification(2)
        tabMenuButtons.forEach { $0.alpha = 1.0 }
        settingsButton.alpha = 0.6
        
    }
    
    @IBAction func moodTabButtonClicked(sender: AnyObject) {
        postNotification(3)
        tabMenuButtons.forEach { $0.alpha = 1.0 }
        moodButton.alpha = 0.6
        
    }
    
    
    func postNotification(index: Int){
        let notificationCenter = NSNotificationCenter.defaultCenter()
        switch index {
        case 0:
            notificationCenter.postNotification(NSNotification(name: Navigation.AudioSelected, object: self))
        case 1:
            notificationCenter.postNotification(NSNotification(name: Navigation.VideoSelected, object: self))
        case 2:
            notificationCenter.postNotification(NSNotification(name: Navigation.SettingsSelected, object: self))
        case 3:
            notificationCenter.postNotification(NSNotification(name: Navigation.MoodSelected, object: self))
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
