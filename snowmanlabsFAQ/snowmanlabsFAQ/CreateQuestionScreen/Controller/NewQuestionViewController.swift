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
        
        
        //Notifications used to make sure that screen content will be visible when keyboard is open
        NotificationCenter.default.addObserver(self, selector: #selector(updateScrollViewSize(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //Add gesture to dismiss keyboard on view tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
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
            QuestionsManager().saveQuestion(newQuestion: newQuestion) { (savedSuccessfully) in
                if savedSuccessfully {
                    //QuestionsDAO().saveQuestion(with: newQuestion)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    //Question will be always saved on DAO, and API will not be verified. If fails to save now, will save when QuestionManager sync the API and local data
                    //So if error was found, was on local data and would need debug to check the error cause, not simple as API save that would be usually internet conection
                    
                    //showAlertMessage(title: "Erro ao salvar nova questão", text: "Ocorreu um erro ao salvar a nova questão. Por favor verifique sua conexão com internet")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            showAlertMessage(title: "Não foi possível salvar a questão", text: "O campo de título e de resposta deve estar preenchido. Por favor verifique novamente os campos")
        }
        self.hideActivity()

    }
    
    func showAlertMessage(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func updateScrollViewSize(_ notification: NSNotification) {
       // self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + self.scrollViewPrincipal.frame.height/2)
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
        
        //Check user device type
        let isUserOnPhone = (UIDevice.current.userInterfaceIdiom == .phone)
        
        //Calculate size based on number of cells that should appear. Usefull if in future more colors are available
            //Obs.: If more cores are available, show more on iPad
        let cellsAcross: CGFloat = isUserOnPhone ? 4 : 4
        let spaceBetweenCells: CGFloat = 14
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        
        //Set size manually
//        let dim: CGFloat = isUserOnPhone ? 50 : 72
        return CGSize(width: dim, height: dim)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRowIndex = indexPath.row
        self.colorsCollectionView.reloadData()
    }
}
