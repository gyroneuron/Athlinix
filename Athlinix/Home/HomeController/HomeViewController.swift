//
//  HomeViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/20/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func handleNavigateToCreateGame(_ sender: Any) {
        
        let createGameVC = CreateGameViewController(nibName: "CreateGameViewController", bundle: nil)
        
        self.navigationController!.pushViewController(createGameVC, animated: true)
        
    }
    @IBAction func handleSignOut(_ sender: Any) {
        
        Task {
            do {
                showLoadingIndicator()
                try await AuthServices.shared.signOut()
                
                let loginVC = LoginViewController()
                navigationController?.pushViewController(loginVC, animated: true)
                hideLoadingIndicator()
            } catch {
                hideLoadingIndicator()
                showAlert(title: "Error", message: "Error signing out")
            }
        }
        
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
