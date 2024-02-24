//
//  HomeViewController.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 21/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTopBar: HomeTopBarView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortingFilterView: UIStackView!
    @IBOutlet weak var booksListView: UICollectionView!
    
    @IBOutlet weak var titleSortButton: UIButton!
    @IBOutlet weak var averageSortButton: UIButton!
    @IBOutlet weak var hitsSortButton: UIButton!
    
    let cellId = "booksList"
    let bookDetailsVM = BookDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTopBar.delegate = self
        homeTopBar.layoutIfNeeded()
        
        let nib = UINib(nibName: "BookCoverCell", bundle: nil)
        booksListView.register(nib, forCellWithReuseIdentifier: cellId)
        booksListView.delegate = self
        booksListView.dataSource = self
        
        bookDetailsVM.fetchDetailsApi { [weak self] in
            // reload collection view
            self?.booksListView.invalidateIntrinsicContentSize()
            self?.booksListView.reloadData()
        }
    }
    
    @IBAction func titleSortButtonTapped(_ sender: UIButton) {
        sort(by: .title, withButtonId: sender.accessibilityIdentifier)
    }
    
    @IBAction func averageSortButtonTapped(_ sender: UIButton) {
        sort(by: .averageRating, withButtonId: sender.accessibilityIdentifier)
    }
    
    @IBAction func hitsSortButtonTapped(_ sender: UIButton) {
        sort(by: .readersCount, withButtonId: sender.accessibilityIdentifier)
    }
    
    func sort(by atrribute: SortingAttribute, withButtonId buttonId: String?) {
        titleSortButton.isSelected = titleSortButton.accessibilityIdentifier == buttonId
        averageSortButton.isSelected = averageSortButton.accessibilityIdentifier == buttonId
        hitsSortButton.isSelected = hitsSortButton.accessibilityIdentifier == buttonId
        
        switch atrribute {
        case .title:
            bookDetailsVM.bookDetailsData?.sort() {
                $0.title < $1.title
            }
        case .averageRating:
            bookDetailsVM.bookDetailsData?.sort() {
                $0.ratings_average > $1.ratings_average
            }
        case .readersCount:
            bookDetailsVM.bookDetailsData?.sort() {
                $0.readinglog_count > $1.readinglog_count
            }
        }
        booksListView.reloadData()
    }
    
}
