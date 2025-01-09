//
//  CreateGameViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/30/24.
//

import UIKit

class CreateGameViewController: UIViewController{
    
    //All the Outlets
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yourTeamCollectionView: UICollectionView!
    @IBOutlet weak var yourTeamMembersCollectionView: UICollectionView!
    @IBOutlet weak var addOpponentTeamButton: UIButton!
    @IBOutlet weak var opponentTeamMembersCollectionView: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    
    
    
    var teams: [Teams] = []
    var members: [TeamMembership] = []
    var selectedTeam: Teams?
    var opponentTeam: [Teams] = []
    var opponentMembers: [TeamMembership] = []
    
    private let teamCellId = "TeamCellCollectionViewCell"
    private let memberCellId = "TeamMemberCellCollectionViewCell"
    private let opponentCellId = "OpponentTeamMemberCellCollectionViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupCollectionViews()
    }
    
    private func setupCollectionViews() {
        // Configure collection view delegates and data sources
        let collectionViews = [
            yourTeamCollectionView,
            yourTeamMembersCollectionView,
            opponentTeamMembersCollectionView
        ]
        
        collectionViews.forEach { collectionView in
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
    }
    
    private func registerCells() {
        // Register collection view cells
        yourTeamCollectionView.register(
            UINib(nibName: teamCellId, bundle: nil),
            forCellWithReuseIdentifier: teamCellId
        )
        
        yourTeamMembersCollectionView.register(
            UINib(nibName: memberCellId, bundle: nil),
            forCellWithReuseIdentifier: memberCellId
        )
        
        opponentTeamMembersCollectionView.register(
            UINib(nibName: opponentCellId, bundle: nil),
            forCellWithReuseIdentifier: opponentCellId
        )
    }
    
    @IBAction func opponentTeamButtonTapped(_ sender: Any) {
        // Present modal for selecting opponent team
        
        //open InviteViewController as Modal
        let vc = InviteViewController(nibName: "InviteViewController", bundle: nil)
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard validateInputs() else { return }
        createGame()
    }
    //Navigate to Next Screen for adding scores
    
    private func validateInputs() -> Bool {
        guard let gameName = gameNameTextField.text, !gameName.isEmpty else {
            showAlert(message: "Please enter a game name")
            return false
        }
        
        guard let location = locationTextField.text, !location.isEmpty else {
            showAlert(message: "Please enter a location")
            return false
        }
        
        guard selectedTeam != nil else {
            showAlert(message: "Please select your team")
            return false
        }
        
        guard !opponentTeam.isEmpty else {
            showAlert(message: "Please add an opponent team")
            return false
        }
        
        return true
    }
    
    private func createGame() {
        // Implement game creation logic here
        // This would typically involve creating a game object and saving it
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
}

extension CreateGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch collectionView {
            case yourTeamCollectionView:
                return teams.count
            case yourTeamMembersCollectionView:
                return members.count
            case opponentTeamMembersCollectionView:
                return opponentMembers.count
            default:
                return 0
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch collectionView {
            case yourTeamCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamCellId, for: indexPath) as! TeamCellCollectionViewCell
                cell.configure(with: teams[indexPath.row])
                return cell
                
            case yourTeamMembersCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: memberCellId, for: indexPath) as! TeamMemberCellCollectionViewCell
                cell.configure(with: members[indexPath.row])
                return cell
                
            case opponentTeamMembersCollectionView:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: opponentCellId, for: indexPath) as! OpponentTeamMemberCellCollectionViewCell
                cell.configure(with: opponentMembers[indexPath.row])
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == yourTeamCollectionView {
                selectedTeam = teams[indexPath.row]
                // You might want to fetch members for the selected team here
                // fetchTeamMembers(for: selectedTeam)
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
