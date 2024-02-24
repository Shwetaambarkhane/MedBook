//
//  BookDetailsVM.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 23/02/24.
//

import UIKit

class BookDetailsVM {
    
    var bookDetailsData: [BookDetails]?
    var bookCoverImage: UIImage?
    
    func fetchDetailsApi(with completionBlock: @escaping () -> Void) {
        fetchApi(
            with: "https://openlibrary.org/search.json?title=game&limit=10",
            contentType: .details,
            completionBlock: completionBlock)
    }
    
    func fetchCoverPhoto(with key: String, completionBlock: @escaping () -> Void) {
        if let keyNum = Int(key.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            fetchApi(
                with: "https://covers.openlibrary.org/b/id/\(String(keyNum)).jpg",
                contentType: .coverImg,
                completionBlock: completionBlock)
        }
    }
    
    func fetchApi(with urlString: String,
                  contentType: BookContentType,
                  completionBlock: @escaping () -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                print("No data")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                switch contentType {
                case .details:
                    let allBooks = try decoder.decode(AllBooksDetails.self, from: content)
                    self.bookDetailsData = allBooks.docs
                    break
                case .coverImg:
                    self.bookCoverImage = UIImage(data: content)
                    break
                }
                
                if self.bookDetailsData != nil || self.bookCoverImage != nil {
                    DispatchQueue.main.async {
                        completionBlock()
                    }
                }
            } catch {
                print("Error in JSON Parsing")
            }
        }
        dataTask.resume()
    }
}

