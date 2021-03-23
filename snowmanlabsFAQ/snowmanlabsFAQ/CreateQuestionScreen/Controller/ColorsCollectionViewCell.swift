//
//  ColorsCollectionViewCell.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {

    //MARK: Outlets
    @IBOutlet var colorBackgroundView: UIView!
    @IBOutlet var colorView: UIView!
    @IBOutlet var whiteCheckImg: UIImageView!
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setup()
    }
    
    //MARK: View setup
    func setup() {
        //Set colorView to cornerRadius = width/2
        // Since it is a 1:1 ratio, it will be a circle
        self.colorView.layer.cornerRadius = self.colorView.layer.frame.width/2
        self.colorView.layer.masksToBounds = true
        self.colorBackgroundView.layer.cornerRadius = self.colorBackgroundView.layer.frame.width/2
        self.colorBackgroundView.layer.masksToBounds = true
       
        //Add a border in grey for color view background
        self.colorBackgroundView.layer.borderColor = UIColor(named: "itens_color")?.cgColor
        self.colorBackgroundView.layer.borderWidth = 1
        
    }
    
    func setColor(from cellColor: QuestionColors) {
        self.colorView.backgroundColor = UIColor(named: ColorConstants().COLORS_PREFIX_NAME + cellColor.rawValue) ?? UIColor(named: ColorConstants().COLORS_PREFIX_NAME + ColorConstants().DEFAULT_FAQ_QUESTION_COLOR)
    }
    
    //MARK: Actions
    func toggleSelected() {
        //Toggle check img visibility
        self.whiteCheckImg.isHidden = !self.whiteCheckImg.isHidden
    }
    
    func setSelected(isSelected: Bool) {
        self.whiteCheckImg.isHidden = !isSelected
    }
    
}
