//
//  ForgotPasswordViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/18/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    let loadingIndicator = UIActivityIndicatorView(style: .medium)


    @IBAction func sendResetEmail(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        showLoadingState(true)
        
        Task {
            do {
                _ = try await SupabaseManager.shared.supabase.auth.resetPasswordForEmail(email)
                
            }
            
            await MainActor.run {
                showLoadingState(false)
                showAlert(message: "Reset email sent successfully.")
            }
        }
    }
    
    func setupActivityIndicator() {
            loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .systemOrange
        NextButton.addSubview(loadingIndicator)

            // Center the indicator in the button
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingIndicator.centerXAnchor.constraint(equalTo: NextButton.centerXAnchor),
                loadingIndicator.centerYAnchor.constraint(equalTo: NextButton.centerYAnchor)
            ])
        }
    
    func hideLoadingIndicator() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func showLoadingState(_ isLoading: Bool) {
            if isLoading {
                NextButton.setTitle("", for: .normal) // Hide text
                loadingIndicator.startAnimating()
                NextButton.isEnabled = false
                NextButton.alpha = 0.6
            } else {
                NextButton.setTitle("Next", for: .normal) // Restore text
                loadingIndicator.stopAnimating()
                NextButton.isEnabled = true
                NextButton.alpha = 1.0
            }
        }
            func showAlert(message: String) {
                let alert = UIAlertController(title: "Forgot Password", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
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
