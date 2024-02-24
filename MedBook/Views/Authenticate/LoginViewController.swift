//
//  LoginViewController.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 19/02/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users: [User]?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    func fetchUsers() {
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("Unsuccessful current user fetch request")
        }
    }
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        showErrorMessage()
        
        if errorMessageLabel.text == "" {
            // Navigate to the next screen after successful login
            let homeStoryBoard = UIStoryboard(name: "HomeViewController", bundle:nil)
            let homeVC = homeStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    // MARK: - Helper Methods
    func showErrorMessage() {
        if emailTextField.text == nil || emailTextField.text == "" {
            errorMessageLabel.text = "Email id cannot be empty"
        } else if passwordTextField.text == nil || passwordTextField.text == "" {
            errorMessageLabel.text = "Password cannot be empty"
        } else {
            var isError = false
            var isRegistered = false
            
            users?.forEach { rUser in
                if emailTextField.text == rUser.emailId {
                    isRegistered = true
                    if passwordTextField.text != rUser.password {
                        errorMessageLabel.text = "Wrong password"
                        isError = true
                    }
                }
            }
            
            if !isRegistered {
                errorMessageLabel.text = "This email id is not registered, sign up"
                isError = true
            }
            if !isError {
                errorMessageLabel.text = ""
                return
            }
        }
        view.layoutIfNeeded()
    }
}
