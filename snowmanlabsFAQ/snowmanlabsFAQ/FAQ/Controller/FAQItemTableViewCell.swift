//
//  FAQItemTableViewCell.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit

enum CellIconState: String {
    case expanded = "ic_arrow_up"
    case compressed = "ic_arrow_down"
}

class FAQItemTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet var questionBackgroundView: UIView!
    @IBOutlet var questionFrontView: UIView!
    @IBOutlet var lblQuestionTitle: UILabel!
    @IBOutlet var questionAnswersTxtView: UITextView!
    @IBOutlet var expandCellBtn: UIButton!
    
    
    //MARK: Variables
    var question: Question?
    var faqCellDelegate: FAQCellItemDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.questionFrontView.layer.cornerRadius = 3
        self.questionFrontView.layer.masksToBounds = true
        self.questionBackgroundView.layer.cornerRadius = 3
        self.questionBackgroundView.layer.masksToBounds = true
        self.questionAnswersTxtView.isHidden = true
       // self.questionAnswersTxtView.isUserInteractionEnabled = false
        self.questionAnswersTxtView.isEditable = false
        self.questionAnswersTxtView.isScrollEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(from question: Question) {
        self.question = question
        self.questionBackgroundView.backgroundColor = UIColor(named: self.question?.questionColor?.rawValue ?? "red")
    }
    
    func updateCellState(state: CellIconState) {
        self.expandCellBtn.setImage(UIImage(named: state.rawValue), for: .normal)
        switch state {
        case .compressed:
            self.questionAnswersTxtView.isHidden = true
            break
        case .expanded:
            self.questionAnswersTxtView.isHidden = false
            break
        }
        
        self.setNeedsLayout()
        self.expandCellBtn.setNeedsLayout()
    }
    
    @IBAction func expandCellBtnTapped(_ sender: Any) {
        if let delegate = self.faqCellDelegate {
            delegate.expandTapped(self) { (newState) in
                self.updateCellState(state: newState)
            }
        }
    }
}
