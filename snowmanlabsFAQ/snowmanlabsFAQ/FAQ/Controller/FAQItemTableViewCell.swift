//
//  FAQItemTableViewCell.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit

class FAQItemTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet var questionBackgroundView: UIView!
    @IBOutlet var questionFrontView: UIView!
    @IBOutlet var lblQuestionTitle: UILabel!
    @IBOutlet var questionArrow: UIImageView!
    
    //MARK: Variables
    var question: Question?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.questionFrontView.layer.cornerRadius = 3
        self.questionFrontView.layer.masksToBounds = true
        self.questionBackgroundView.layer.cornerRadius = 3
        self.questionBackgroundView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(from question: Question) {
        self.question = question
        self.questionBackgroundView.backgroundColor = UIColor(named: self.question?.questionColor?.rawValue ?? "red")
    }
    
}
