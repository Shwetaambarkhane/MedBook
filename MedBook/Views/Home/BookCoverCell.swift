//
//  BookCoverCell.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 22/02/24.
//

import UIKit

class BookCoverCell: UICollectionViewCell {

    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var readersCount: UILabel!
    
    func bind(with data: BookDetails) {
        let bookDetailsVM = BookDetailsVM()
        if let authorKey = data.author_key.first {
            bookDetailsVM.fetchCoverPhoto(with: authorKey) { [weak self] in
                self?.coverPhoto.image = bookDetailsVM.bookCoverImage
            }
        }
        
        bookTitle.text = data.title
        author.text = data.author_name.first
        let avgRating = Double(round(100 * data.ratings_average) / 100)
        rating.text = "⭐" + String(avgRating)
        readersCount.text = "📖" + String(data.readinglog_count)
    }
}
