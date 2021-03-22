//
//  customSearchBarControllerContainer.swift
//  snowmanlabsFAQ
//
//  Created by Giovanne Bressam on 22/03/21.
//

import UIKit

//Container to hold the searchbar with a defined size

class CustomSearchBarControllerContainer: UIView {

    let searchBarController: UISearchController

    init(customSearchBarController: UISearchController, delegate: UISearchBarDelegate?) {
        //Initialize serachbarController from this container
        searchBarController = customSearchBarController
        super.init(frame: CGRect.zero)
        searchBarController.searchBar.delegate = delegate

        //Layout changes
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
        self.searchBarController.view.frame = self.searchBarController.searchBar.frame
        self.searchBarController.searchBar.layoutIfNeeded()
        self.searchBarController.searchBar.barTintColor = UIColor(named: "snowmanlabs_blue")
        self.searchBarController.searchBar.setImage(UIImage(named: "ic_search_30x30"), for: .search, state: .normal)
        //self.searchBarController.searchBar.setImage(UIImage(named: "ic_close_30x30"), for: .bookmark, state: .normal)

        addSubview(searchBarController.searchBar)
      }
      override convenience init(frame: CGRect) {
        self.init(customSearchBarController: UISearchController(), delegate: nil)
          self.frame = frame
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func layoutSubviews() {
        super.layoutSubviews()
        searchBarController.searchBar.frame = bounds
      }

}
