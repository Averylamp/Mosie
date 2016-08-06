//
//  MoodCollectionViewCell.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class MoodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moodMonsterImage: UIImageView!
    
    @IBOutlet weak var moodTitleLabel: UILabel!
    
    //Background colors to pick from
    let bgColors = [UIColor.greenColor(),UIColor.orangeColor(), UIColor.redColor(), UIColor.blueColor(),UIColor.brownColor()]
    
    //random colors from array
    func randomizeBGColor(){
        let randomColor = bgColors[self.tag % bgColors.count]
        self.backgroundColor = randomColor
    }
    
    
}
