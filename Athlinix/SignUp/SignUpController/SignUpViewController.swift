//
//  SignUpViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/20/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var googleButtonOutlet: UIButton!
    @IBOutlet weak var appleButtonOutlet: UIButton!
    @IBOutlet weak var nameTFOutlet: UITextField!
    @IBOutlet weak var hidePasswordBtnOutlet: UIButton!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var emailTFOutlet: UITextField!
    
    @IBAction func handleLoginWithGoogle(_ sender: Any) {
    }
    
    @IBAction func handleLoginWithApple(_ sender: Any) {
    }
    
    
    //actions
    @IBAction func handleHidePassword(_ sender: Any) {
    }
    @IBAction func handleRegister(_ sender: Any) {
        guard let name = nameTFOutlet.text,
              let email = emailTFOutlet.text,
              let password = passwordTFOutlet.text else {
            showAlert(title: "Signup Error", message: "Please fill all fields")
            return
        }
        
        showLoadingIndicator()
        
        Task {
            do {
                _ = try await AuthServices.shared.signUp(
                    email: email,
                    password: password,
                    fullName: name
                )
                
                await MainActor.run {
                    hideLoadingIndicator()
                    
                    showAlert(title: "Signup Success", message: "You have successfully Registered to Athlinix")
                }
            } catch {
                await MainActor.run {
                    hideLoadingIndicator()
                    showAlert(title: "Enxception", message: error.localizedDescription)
                }
            }
        }
    }
    @IBAction func handleNavigateSignin(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func handleRegisterWithGoogle(_ sender: Any) {
    }
    @IBAction func handleRegisterWithApple(_ sender: Any) {
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
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        googleButtonOutlet.layer.cornerRadius = 15
        googleButtonOutlet.layer.borderWidth = 1
        googleButtonOutlet.layer.borderColor = UIColor.black.cgColor
        
        
        appleButtonOutlet.layer.cornerRadius = 15
        appleButtonOutlet.layer.borderWidth = 1
        appleButtonOutlet.layer.borderColor = UIColor.black.cgColor
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        

    
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
