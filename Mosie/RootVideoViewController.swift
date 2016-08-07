//
//  RootVideoViewController.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit
import YoutubeEngine

class RootVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let engine = Engine(key: "AIzaSyCgwWIve2NhQOb5IHMdXxDaRHOnDrLdrLg")
        let request = Search(.Term("VEVO", [.Video: [.Statistics, .ContentDetails], .Channel: [.Statistics]]))
        engine.search(request)
            .startWithNext {
                page in
                let formattedItems = page.items.enumerate().map { "[\($0)] = \($1)" }
                print("VEVO:\n\(formattedItems.joinWithSeparator("\n"))")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
