//
//  HomeTopBarView.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 21/02/24.
//

import UIKit

class HomeTopBarView: UIView {

    @IBOutlet weak var bookMarkImg: UIImageView!
    @IBOutlet weak var logoutImg: UIImageView!
    
    var delegate: HomeTopBarViewDelegate?
    
    override func layoutSubviews() {
        if let bookMarkImage = UIImage(systemName: "bookmark.fill") {
            bookMarkImg.image = bookMarkImage
        }
        if let logoutImage = UIImage(systemName: "delete.backward") {
            logoutImg.image = logoutImage
            logoutImg.tintColor = .red
        }
        
        let bookMarkGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bookMarkImgTapped(_:)))
        bookMarkImg.isUserInteractionEnabled = true
        bookMarkImg.addGestureRecognizer(bookMarkGestureRecognizer)
        
        let logoutGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoutImgTapped(_:)))
        logoutImg.isUserInteractionEnabled = true
        logoutImg.addGestureRecognizer(logoutGestureRecognizer)
    }
    
    @objc func bookMarkImgTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
    }
    
    @objc func logoutImgTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.logoutImgTapped()
    }
}
