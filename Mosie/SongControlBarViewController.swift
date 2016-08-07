//
//  SongControlBarViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class SongControlBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songArtistLabel: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton!

    @IBOutlet weak var songProgressView: UIProgressView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playPauseClicked(sender: AnyObject) {
        
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
