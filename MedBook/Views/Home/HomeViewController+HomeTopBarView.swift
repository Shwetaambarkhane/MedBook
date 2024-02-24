//
//  HomeViewController+HomeTopBarView.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 24/02/24.
//

extension HomeViewController: HomeTopBarViewDelegate {
    func bookMarkImgTapped() {
        
    }
    
    func logoutImgTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
