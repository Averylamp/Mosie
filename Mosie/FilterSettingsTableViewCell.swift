//
//  FilterSettingsTableViewCell.swift
//  Mosie
//
//  Created by Avery Lamp on 8/7/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class FilterSettingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var filterWordLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    var filterWord:String = ""
    var hiddenFilterWord:String = ""
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupFilterCellWithWord(word:String){
        let stringStart = word.substringToIndex(word.endIndex.advancedBy(0 - word.characters.count + 1))
        print(stringStart)
        
        
    }
    
    @IBAction func removeFilterWordClicked(sender: AnyObject) {
        
        
    }

}
