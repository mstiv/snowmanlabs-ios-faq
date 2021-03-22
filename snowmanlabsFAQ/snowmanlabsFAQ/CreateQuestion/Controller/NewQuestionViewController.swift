//
//  NewQuestionViewController.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

class NewQuestionViewController: UIViewController {
    
    @IBOutlet var newQuestionView: UIView!
    @IBOutlet var questionTitleLbl: UILabel!
    @IBOutlet var answerTitleLbl: UILabel!
    @IBOutlet var questionTitleTxtField: UITextField!
    @IBOutlet var questionAnswerTxtView: UITextView!
    @IBOutlet var colorsTitleLbl: UILabel!
    @IBOutlet var colorsCollectionView: UICollectionView!
    @IBOutlet var addQuestionBtn: UIButton!
    @IBOutlet var addQuestionActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupView() {
        //Corner radius on all itens
        
        //Set all texts to default value
        
        //Add border on all textfield and textView from question title and answer
    }

}
