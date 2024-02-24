//
//  SignupViewController.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 20/02/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
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
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        showErrorMessage()
        
        if errorMessageLabel.text == "" {
            let user = User(context: context)
            user.emailId = emailTextField.text
            user.password = passwordTextField.text
            
            // save context
            do {
                try context.save()
            } catch {
                print("Unsuccessful save request")
            }
            
            // fetch data
            fetchUsers()
            
            // Navigate to the next screen after successful login
            let loginStoryBoard = UIStoryboard(name: "LoginViewController", bundle:nil)
            let loginVC = loginStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    // MARK: - Helper Methods
    func showErrorMessage() {
        errorMessageLabel.text = ""
        
        if emailTextField.text == nil || emailTextField.text == "" {
            errorMessageLabel.text = "Email id cannot be empty"
        } else if passwordTextField.text == nil || passwordTextField.text == "" {
            errorMessageLabel.text = "Password cannot be empty"
        } else if !isValidEmail(emailTextField.text!) {
            errorMessageLabel.text = "Enter valid email id"
        } else if !isValidPassword(passwordTextField.text!) {
            errorMessageLabel.text = "Password should be minimum 8 characters, contain at least 1 number, 1 uppercase letter, and 1 special character"
        } else {
            users?.forEach { rUser in
                if emailTextField.text == rUser.emailId {
                    errorMessageLabel.text = "This email id is already registered, login"
                }
            }
        }
        view.layoutIfNeeded()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }

}
