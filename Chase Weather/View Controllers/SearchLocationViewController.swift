//
//  SearchLocationViewController.swift
//  Chase Weather
//
//  Created by John Kang on 5/15/23.
//

import UIKit

class SearchLocationViewController: UIViewController {

    var searchController: UISearchController? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
        searchController = UISearchController(searchResultsController: SearchResultsViewController(parentVC: self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search Location"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController?.searchBar.placeholder = "City Name"
        navigationItem.searchController = searchController
        searchController?.searchBar.delegate = self
    }
}

extension SearchLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController?.searchBar.text, let resultsController = searchController?.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        resultsController.reloadTable(cityName: text)
    }
}
