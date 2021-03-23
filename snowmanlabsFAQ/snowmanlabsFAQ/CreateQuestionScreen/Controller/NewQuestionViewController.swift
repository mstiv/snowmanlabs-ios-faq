//
//  NewQuestionViewController.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

class NewQuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Outlets
    @IBOutlet var newQuestionView: UIView!
    @IBOutlet var questionTitleLbl: UILabel!
    @IBOutlet var answerTitleLbl: UILabel!
    @IBOutlet var questionTitleTxtField: UITextField!
    @IBOutlet var questionAnswerTxtView: UITextView!
    @IBOutlet var colorsTitleLbl: UILabel!
    @IBOutlet var colorsCollectionView: UICollectionView!
    @IBOutlet var addQuestionBtn: UIButton!
    @IBOutlet var addQuestionActivityIndicator: UIActivityIndicatorView!
    
    //MARK: Variables
    var availableColors:[QuestionColors] = [.red, .green, .yellow, .blue]
    var selectedRowIndex : Int = 0

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: View Setup
    func setupView() {
        //Configure navigation bar
        self.title = "Adicionar Pergunta"
        let backButtonItem = UIBarButtonItem(
            title: .none, style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem

        
        //Corner radius and border on all itens
        //background view/container
        self.newQuestionView.layer.cornerRadius = 6
        self.newQuestionView.layer.masksToBounds = true
        
        //QuestionTitle
        self.questionTitleTxtField.layer.cornerRadius = 6
        self.questionTitleTxtField.layer.masksToBounds = true
        self.questionTitleTxtField.layer.borderColor = UIColor(named: "itens_color")?.cgColor
        self.questionTitleTxtField.layer.borderWidth = 1
        
        //QuestionAnswer
        self.questionAnswerTxtView.layer.cornerRadius = 6
        self.questionAnswerTxtView.layer.masksToBounds = true
        self.questionAnswerTxtView.layer.borderColor = UIColor(named: "itens_color")?.cgColor
        self.questionAnswerTxtView.layer.borderWidth = 1
        
        
        //Set all texts to default value
        self.questionTitleLbl.text = " Título da Pergunta "
        self.answerTitleLbl.text = " Resposta da Pergunta "
        self.colorsTitleLbl.text = "Cor"
        self.addQuestionBtn.setTitle("Adicionar", for: .normal)
        
        //Hide needed itens
        self.addQuestionActivityIndicator.isHidden = true
        
        //Register custom cell
        let colorsCollectionViewCellNib = UINib(nibName: "ColorsCollectionViewCell", bundle:nil)
        self.colorsCollectionView.register(colorsCollectionViewCellNib, forCellWithReuseIdentifier: "faqColorsCollectionCell")
    }

    
    func hideActivity() {
        self.addQuestionBtn.setTitle("Adicionar", for: .normal)
        self.addQuestionActivityIndicator.isHidden = true
        self.addQuestionActivityIndicator.stopAnimating()
    }
    
    func showActivity() {
        self.addQuestionBtn.setTitle(.none, for: .normal)
        self.addQuestionActivityIndicator.isHidden = false
        self.addQuestionActivityIndicator.startAnimating()
    }
    
    //MARK: Actions
    @IBAction func addQuestionBtnTapped(_ sender: UIButton) {
        self.showActivity()
        if self.allDataIsValid() {
            let newQuestion = Question()
            newQuestion.title = self.questionTitleTxtField.text
            newQuestion.answer = self.questionAnswerTxtView.text
            newQuestion.color = self.availableColors[self.selectedRowIndex]
            QuestionsDAO().saveQuestion(with: newQuestion)
            self.navigationController?.popViewController(animated: true)
        }
        self.hideActivity()

    }
    
    
    //MARK: Data validation
    func allDataIsValid() -> Bool{
        var dataStatus = (self.questionTitleTxtField.text != "" && self.questionTitleTxtField.text != " ")
        dataStatus = (dataStatus && (self.questionAnswerTxtView.text != "" && self.questionAnswerTxtView.text != " "))
        return dataStatus
    }
    
    //MARK: CollectionView Delegate and Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "faqColorsCollectionCell", for: indexPath) as? ColorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let isSelectedRow: Bool = (selectedRowIndex == indexPath.row)
        cell.setColor(from: self.availableColors[indexPath.row])
        cell.setSelected(isSelected: isSelectedRow)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //ContentCell
        if (indexPath.section == 0) {
            //Check user device type
            let isUserOnPhone = (UIDevice.current.userInterfaceIdiom == .phone)
            
            //Set layout according to device type
            //Obs.: If more cores are available, show more on iPad
            let cellsAcross: CGFloat = isUserOnPhone ? 4 : 4
            let spaceBetweenCells: CGFloat = 14
            let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: dim, height: dim)
        } //LoadingData cell
        else if (indexPath.section == 1) {
            let collectionViewWidth = self.colorsCollectionView.frame.width
            return CGSize(width: collectionViewWidth, height: 200)
        }

        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        self.colorsCollectionView.reloadData()
    }
}
