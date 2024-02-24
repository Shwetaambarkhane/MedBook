//
//  LandingViewController.swift
//  MedBook
//
//  Created by Shweta Ambarkhane on 19/02/24.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "LoginViewController", bundle:nil)
        let loginVC = loginStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let signupStoryBoard = UIStoryboard(name: "SignupViewController", bundle:nil)
        let signupVC = signupStoryBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}
