//
//  ColorsCollectionViewCell.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var colorView: UIView!
    @IBOutlet var whiteCheckImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        //Set colorView to cornerRadius = width/2
        // Since it is a 1:1 ratio, it will be a circle
        
        //Add a cell border in grey
        
        //Start with check hidden
    }

    func toggleSelected() {
        //Toggle check img visibility
        
    }
    
}
