//
//  FAQViewController.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 21/03/21.
//

import UIKit

protocol FAQCellItemDelegate {
    func expandTapped(_ cell: FAQItemTableViewCell, completion: @escaping(_ newState: CellIconState) -> Void)
}

class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate, FAQCellItemDelegate {


    //MARK: Outlets
    @IBOutlet var faqTableView: UITableView!
    @IBOutlet var addQuestionView: UIView!
    @IBOutlet var addQuestionLbl: UILabel!
    @IBOutlet var createNewQuestionBtn: CustomImageButton!
    
    //MARK: Variables
    var searchBarController = UISearchController(searchResultsController: nil)
    var searching : Bool = false
    var selectedRowIndex : Int = -1
    
    var faqQuestions: Questions? {
        didSet {
            self.faqTableView.reloadData()
        }
    }
    var allQuestions: Array<Question>?
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Get data
        self.reloadFaqQuestions()
    }
    
    //MARK: View setup
    func setupView() {
        self.searchBarController.searchBar.delegate = self
        self.searchBarController.delegate = self
        self.searchBarController.searchResultsUpdater = self
        self.searchBarController.searchBar.showsBookmarkButton = false
        
        //Add title and search to navigationController
        showDefaultNavigationBar()
        
        
        //Add corner radius to addQuestionView
        self.addQuestionView.layer.cornerRadius = 3
        self.addQuestionView.layer.masksToBounds = true
        
        
        //Add gesture to addQuestionView
        
        //Register custom cell
        let faqItemCell = UINib(nibName: "FAQItemTableViewCell", bundle:nil)
        self.faqTableView.register(faqItemCell, forCellReuseIdentifier: "faqCell")
        
        //Set btn text
        self.createNewQuestionBtn.setTitle("Adicionar Pergunta", for: .normal)
    }
    
    
    //MARK: Methods
    
    //Reset all data
    func reloadFaqQuestions() {
        QuestionsManager().fetchFAQQuestions(completion: { (newQuestions) in
            self.faqQuestions = newQuestions
            self.allQuestions = self.faqQuestions?.questions
        })
    }
    
    
    func showDefaultNavigationBar() {
        //Reset navigation
        navigationItem.titleView = .none
        self.title = "Perguntas Frequentes"
        
        //create a new button
        let searchButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        searchButton.setImage(UIImage(named: "ic_search_30x30"), for: UIControl.State.normal)
        //add function for button
        searchButton.addTarget(self, action: #selector(self.searchButtonPressed), for: UIControl.Event.touchUpInside)
        //assign button to navigationbar
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = searchBarButton
        //set frame. No need to change size since icon is on correct size now
    //        let currWidth = searchBarButton.customView?.widthAnchor.constraint(equalToConstant: 30)
    //        currWidth?.isActive = true
    //        let currHeight = searchBarButton.customView?.heightAnchor.constraint(equalToConstant: 30)
    //        currHeight?.isActive = true
    }
    
    func showSearchBarOnNavigationBar() {
        //Set navigation
        self.navigationItem.rightBarButtonItem = .none
        
        //Instantiate custom searchbar container to be placed as titleView on navigation
        let searchBarContainer = CustomSearchBarControllerContainer(customSearchBarController: searchBarController, delegate: self)
        searchBarContainer.frame = (self.navigationController?.navigationBar.frame)!
        //CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 50)//

        //Set the custom searchBar
        navigationItem.titleView = searchBarContainer
        self.definesPresentationContext = true
    }
    
    @objc func searchButtonPressed() {
        if (searching) {
            //hide searchBar
            searching = false
            showDefaultNavigationBar()
        } else {
            //show searchbar
            searching = true
            showSearchBarOnNavigationBar()
        }
    }
    
    
    //MARK: SearchBar delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        self.showDefaultNavigationBar()
        searchBar.endEditing(true)
        
        self.reloadFaqQuestions()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Reset to all questions for each search, so if user deleted characters on search text, it can find more results
        self.faqQuestions?.questions =  self.allQuestions
        
        //Perform search
        if let text = searchBar.text, let currentQuestionsData = self.faqQuestions, let allQuestions = currentQuestionsData.questions {
            if (text != "") {
                print("updating search results \(text)")
                let foundQuestions = allQuestions.filter { (question) -> Bool in
                    var isTitleOnFilter: Bool = false
                    var isAnswerOnFilter: Bool = false
                    
                    if let title = question.title {
                        isTitleOnFilter = title.contains(text)
                    }
                    if let answer = question.answer {
                        isAnswerOnFilter = answer.contains(text)
                    }
                    
                    return isAnswerOnFilter || isTitleOnFilter
                }
                
                self.faqQuestions?.questions = foundQuestions
                self.faqTableView.reloadData()
                self.faqTableView.layoutIfNeeded()
            }
        }
    }

    // MARK: Actions
    @IBAction func createNewQuestionTapped(_ sender: CustomImageButton) {
        let newQuestionVC = NewQuestionViewController(nibName: "NewQuestionViewController", bundle: nil)
        self.navigationController?.pushViewController(newQuestionVC, animated: true)
    }
    
    
    
    // MARK: TableView datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let questions = faqQuestions?.questions {
           return questions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isUserOnPhone = (UIDevice.current.userInterfaceIdiom == .phone)

        if let cell = tableView.cellForRow(at: indexPath) as? FAQItemTableViewCell {
            if indexPath.row == selectedRowIndex {
                cell.updateCellState(state: .expanded)
                return isUserOnPhone ? 170 : 320 //Expanded
            }
            cell.updateCellState(state: .compressed)
            return isUserOnPhone ? 80 : 120 //Not expanded
        }
        return isUserOnPhone ? 80 : 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let questions = faqQuestions?.questions {
            let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FAQItemTableViewCell
            cell.faqCellDelegate = self
            cell.setupCell(from: questions[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }


    
    //MARK: Cell Item Delegate
    func expandTapped(_ cell: FAQItemTableViewCell, completion: @escaping(_ newState: CellIconState) -> Void) {
        if let indexPath = self.faqTableView.indexPath(for: cell) {
            if self.selectedRowIndex == indexPath.row {
                self.selectedRowIndex = -1
                completion(.compressed)
            } else {
                self.selectedRowIndex = indexPath.row
                completion(.expanded)
            }
            self.faqTableView.reloadRows(at: [indexPath], with: .none)
            self.faqTableView.layoutIfNeeded()
            self.faqTableView.performBatchUpdates(nil, completion: nil)
        }
    }
}
