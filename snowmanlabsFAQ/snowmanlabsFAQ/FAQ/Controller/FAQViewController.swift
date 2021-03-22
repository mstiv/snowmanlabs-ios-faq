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
    
    //MARK: Variables
    var searchBarController = UISearchController(searchResultsController: nil)
    var searching : Bool = false
    var selectedRowIndex : Int = -1
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }

    
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
        
        //General changeds since it is only screen with this. If needed, could apply this changes only to searchBar on current screen (that is one of this controller variables)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = .none
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).image = UIImage(named: "ic_close_30x30")
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).placeholder = "Procurar perguntas"
        
        self.searchBarController.searchBar.showsCancelButton = true
        self.searchBarController.hidesNavigationBarDuringPresentation = false
        self.searchBarController.searchBar.searchBarStyle = .prominent
        self.searchBarController.searchBar.isTranslucent = false
        self.searchBarController.searchBar.sizeToFit()
        self.searchBarController.searchBar.barTintColor = UIColor(named: "snowmanlabs_blue")
        self.searchBarController.searchBar.setImage(UIImage(named: "ic_search_30x30"), for: .search, state: .normal)
        //self.searchBarController.searchBar.setImage(UIImage(named: "ic_close_30x30"), for: .bookmark, state: .normal)


        //Set the custom searchBar
        navigationItem.titleView = searchBarController.searchBar
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
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
//        print("closing searchbar")
//        self.showDefaultNavigationBar()
    }
    
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //searchController.searchBar.showsBookmarkButton = true
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
       // searchController.searchBar.showsBookmarkButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.showDefaultNavigationBar()
        searchBar.endEditing(true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        print("updating search results")
    }

    
    // MARK: TableView datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? FAQItemTableViewCell {
            if indexPath.row == selectedRowIndex {
                cell.updateCellState(state: .expanded)
                return 270 //Expanded
            }
            cell.updateCellState(state: .compressed)
            return 80 //Not expanded
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell") as! FAQItemTableViewCell
        cell.faqCellDelegate = self
        return cell
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
