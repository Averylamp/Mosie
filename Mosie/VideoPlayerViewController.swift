//
//  VideoPlayerViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/7/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class VideoPlayerViewController: UIViewController, YTPlayerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(playerView)
        self.view.addConstraint(NSLayoutConstraint(item: playerView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: playerView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: -100.0))
        self.view.addConstraint(NSLayoutConstraint(item: playerView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: playerView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 0.0))
        
        
        playerView.setPlaybackQuality(.Small)
        playerView.delegate = self
        self.playerView.loadWithVideoId("UXENyhFMrxk")
        print("Player view loaded")
        // Do any additional setup after loading the view.
    }
    
    var playerView: YTPlayerView! = nil

    @IBAction func videoPlayPauseClicked(sender: AnyObject) {
        print("play clicked")
            playerView.playVideo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Playback State
    
    func playerView(playerView: YTPlayerView, didChangeToState state: YTPlayerState) {
        switch state {
        case .Playing:
            print("Playing")
        case .Paused:
            print("Paused")
        case .Buffering:
            print("Buffering")
        case .Unstarted:
            print("Unstarted")
        case .Unknown:
            print("Unknown")
        default:
            print("Unknown")
        }
    }
    
    func playerView(playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print("Error recieved - \(error)")
    }

    func playerViewDidBecomeReady(playerView: YTPlayerView) {
        print("Player Ready")
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
