//
//  ResetPasswordViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 2/2/25.
//

import UIKit
import Auth

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var resetCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🔑 ResetPasswordViewController Loaded Successfully!")
        if let code = resetCode {
                    print("📩 Reset Code: \(code)")
                    authenticateWithResetCode(code)
                } else {
                    showAlert(message: "Invalid reset link.")
                }
    }
    
    private func authenticateWithResetCode(_ code: String) {
            Task {
                do {
                    let session = try await SupabaseManager.shared.supabase.auth.exchangeCodeForSession(authCode: code)
                    print("✅ Session retrieved successfully: \(session)")
                } catch {
                    print("❌ Failed to authenticate: \(error.localizedDescription)")
                    await MainActor.run {
                        showAlert(message: "Failed to authenticate. Please try again.")
                    }
                }
            }
        }
    
    @IBAction func handleResetPassword(_ sender: Any) {
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        
        
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please enter your confirm password.")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "Password and confirm password should be same.")
            return
        }
        
        
        Task {
            do {
                _ = try await SupabaseManager.shared.supabase.auth.update(user: UserAttributes(password: confirmPassword))
                
                await MainActor.run {
                    showAlert(message: "Password reset successfully.", goToLogin: true)
                }
            } catch {
                await MainActor.run {
                    showAlert(message: error.localizedDescription)
                }
            }
        }}
    
    
    
    func showAlert(message: String, goToLogin: Bool = false) {
            let alert = UIAlertController(title: "Reset Password", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                if goToLogin {
                    let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                    self.dismiss(animated: true)
                }
            })
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
