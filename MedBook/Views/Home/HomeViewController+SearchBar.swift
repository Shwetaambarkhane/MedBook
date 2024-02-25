//
//  HomeViewController+SearchBar.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 25/02/24.
//

import UIKit

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            bookDetailsVM.bookDetailsData = bookDetailsVM.bookDetailsData?.filter {
                $0.title.contains(searchText)
            }
            booksListView.reloadData()
        }
    }
}
