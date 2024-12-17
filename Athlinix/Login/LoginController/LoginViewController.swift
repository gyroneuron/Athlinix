//
//  LoginViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    //All Outlet
    @IBOutlet weak var googleButtonOutlet: UIButton!
    @IBOutlet weak var appleButtonOutlet: UIButton!
    @IBOutlet weak var emailTFOutlet: UITextField!
    
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    @IBAction func handleForgotPassword(_ sender: Any) {
    }
    @IBAction func handleLogin(_ sender: Any) {
        
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        
        guard let email = emailTFOutlet.text,
        let password = passwordTFOutlet.text else {
            showAlert(title: "Error", message: "Please enter email")
            return
        }
        
        showLoadingIndicator()
        
        Task {
            do {
                _ = try await AuthServices.shared.signIn(email: email, password: password)
                
                await MainActor.run {
                    hideLoadingIndicator()
                    self.navigationController!.pushViewController(vc, animated: true)
                    showAlert(title: "Success", message: "Login Successfully")
                }
                
            } catch {
                hideLoadingIndicator()
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
        
        
        
    }
    @IBAction func handleSignUp(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
         self.navigationController!.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func handleLoginWithGoogle(_ sender: Any) {
    }
    @IBAction func handleLoginWithApple(_ sender: Any) {
    }
    
    func showAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
    
    func hideLoadingIndicator() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleButtonOutlet.layer.cornerRadius = 15
        googleButtonOutlet.layer.borderWidth = 1
        googleButtonOutlet.layer.borderColor = UIColor.black.cgColor
        
        
        appleButtonOutlet.layer.cornerRadius = 15
        appleButtonOutlet.layer.borderWidth = 1
        appleButtonOutlet.layer.borderColor = UIColor.black.cgColor
        

    }
    
 


    /*
    // MARK: - Navigation
     
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
