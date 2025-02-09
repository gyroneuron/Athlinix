//
//  LoginViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/17/24.
//

import UIKit

class LoginViewController: UIViewController {
    var window: UIWindow?
    //All Outlet
    @IBOutlet weak var googleButtonOutlet: UIButton!
    @IBOutlet weak var appleButtonOutlet: UIButton!
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var EmailInputBox: UIStackView!
    @IBOutlet weak var LoginButtonOutlet: UIButton!
    @IBOutlet weak var PasswordInputBox: UIStackView!
    
    
    
    override func viewDidLoad() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
       
    
        self.view.addGestureRecognizer(tap)
        super.viewDidLoad()
        
        setupActivityIndicator()
        setupUI()
        
    }
    
    let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    func setupUI() {
            let buttons = [googleButtonOutlet, appleButtonOutlet]
            buttons.forEach {
                $0?.layer.cornerRadius = 15
                $0?.layer.borderWidth = 1
                $0?.layer.borderColor = UIColor.lightGray.cgColor
            }

            let inputBoxes = [EmailInputBox, PasswordInputBox]
            inputBoxes.forEach {
                $0?.layer.cornerRadius = 15
                $0?.layer.borderWidth = 1
                $0?.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    
    //MARK: To Dismiss Keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
        
    }
    
    
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    
    
    @IBAction func handleForgotPassword(_ sender: Any) {
        let vc = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)

         self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    
    
    //MARK: Login Button
    @IBAction func handleLogin(_ sender: Any) {
        
        let _ = HomeViewController(nibName: "HomeViewController", bundle: nil)

                guard let email = emailTFOutlet.text, let password = passwordTFOutlet.text,
                      !email.isEmpty, !password.isEmpty else {
                    showAlert(title: "Error", message: "Please enter email and password")
                    return
                }

                showLoadingState(true)

                Task {
                    do {
                        _ = try await AuthServices.shared.signIn(email: email, password: password)
                        
                        await MainActor.run {
                            showLoadingState(false)
                            navigateToMainScreen()
                            showAlert(title: "Success", message: "Login Successfully")
                        }
                    } catch {
                        showLoadingState(false)
                        showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
    }
    
    func navigateToMainScreen() {
        // Get the active window scene (the scene for the app's main window)
        if let windowScene = view.window?.windowScene {
            let window = windowScene.windows.first { $0.isKeyWindow }
            
            // Create TabBarController and set it as the root view controller
            let tabBarController = TabBarController()  // Initialize your TabBarController
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
    }
    
    
    
    //MARK: SignUp Button
    @IBAction func handleSignUp(_ sender: Any) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
         self.navigationController!.pushViewController(vc, animated: false)
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func handleLoginWithGoogle(_ sender: Any) {
    }
    @IBAction func handleLoginWithApple(_ sender: Any) {
    }
    
    
    
    func showAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }
    
    
    
    func setupActivityIndicator() {
            loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .systemOrange
            LoginButtonOutlet.addSubview(loadingIndicator)

            // Center the indicator in the button
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingIndicator.centerXAnchor.constraint(equalTo: LoginButtonOutlet.centerXAnchor),
                loadingIndicator.centerYAnchor.constraint(equalTo: LoginButtonOutlet.centerYAnchor)
            ])
        }
    
    func hideLoadingIndicator() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func showLoadingState(_ isLoading: Bool) {
            if isLoading {
                LoginButtonOutlet.setTitle("", for: .normal) // Hide text
                loadingIndicator.startAnimating()
                LoginButtonOutlet.isEnabled = false
                LoginButtonOutlet.alpha = 0.6
            } else {
                LoginButtonOutlet.setTitle("Login", for: .normal) // Restore text
                loadingIndicator.stopAnimating()
                LoginButtonOutlet.isEnabled = true
                LoginButtonOutlet.alpha = 1.0
            }
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
