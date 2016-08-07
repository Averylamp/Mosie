//
//  VideoTableViewCell.swift
//  Mosie
//
//  Created by Avery Lamp on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImageThumbnail: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoChannelLabel: UILabel!
    @IBOutlet weak var videoViewsCountLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
