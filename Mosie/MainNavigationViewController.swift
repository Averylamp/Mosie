//
//  MainNavigationViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    private var audioSelectedObserver: NSObjectProtocol?
    private var videoSelectedObserver: NSObjectProtocol?
    private var settingsSelectedObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        addObservers()
    }
    override func viewWillDisappear(animated: Bool) {
        removeObservers()
    }
    
    func addObservers(){
        let notificationCenter = NSNotificationCenter.defaultCenter()
        audioSelectedObserver = notificationCenter.addObserverForName(MainSideViewController.Navigation.AudioSelected, object: nil, queue: nil, usingBlock: { (notification) in
            let audioVC = UIStoryboard(name: "AudioStoryboard", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("AudioVCMain")
            self.setViewControllers([audioVC], animated: true)
            
        })
        videoSelectedObserver = notificationCenter.addObserverForName(MainSideViewController.Navigation.VideoSelected, object: nil, queue: nil, usingBlock: { (notification) in
            
            let videoVC = UIStoryboard(name: "VideoStoryboard", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MoodVC")
            
                self.setViewControllers([videoVC], animated: true)
        })
        settingsSelectedObserver = notificationCenter.addObserverForName(MainSideViewController.Navigation.SettingsSelected, object: nil, queue: nil, usingBlock: { (notification) in
            
            let videoVC = UIStoryboard(name: "SettingsStoryboard", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("SettingsVC")
            
            self.setViewControllers([videoVC], animated: true)
        })
    }
    
    func removeObservers(){
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        if audioSelectedObserver != nil{
            notificationCenter.removeObserver(audioSelectedObserver!)
        }
        if videoSelectedObserver != nil{
            notificationCenter.removeObserver(videoSelectedObserver!)
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
