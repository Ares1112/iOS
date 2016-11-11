//
//  TableViewRow.swift
//  MusicAdvanced
//
//  Created by Arek on 02/11/2016.
//  Copyright © 2016 agh. All rights reserved.
//

import Foundation

import UIKit

class TableViewRow: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
