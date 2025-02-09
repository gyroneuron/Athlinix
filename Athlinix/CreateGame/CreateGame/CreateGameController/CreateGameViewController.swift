//
//  CreateGameViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/30/24.
//

import UIKit

class CreateGameViewController: UIViewController{
    
    
    @IBOutlet weak var GameHeaderViewOutlet: UIView!
    //All the Outlets
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yourTeamCollectionView: UICollectionView!
    @IBOutlet weak var yourTeamMembersCollectionView: UICollectionView!
    @IBOutlet weak var addOpponentTeamButton: UIButton!
    @IBOutlet weak var opponentTeamMembersCollectionView: UICollectionView!
    @IBOutlet weak var createButton: UIButton!
    
    
    
    var teams: [TeamTable] = []
    var members: [TeamMembershipTable] = []
    var selectedTeam: TeamTable?
    var selectedOppoTeam: TeamTable?
    var opponentTeam: TeamTable?
    var opponentMembers: [TeamMembershipTable] = []
    
    private let teamCellId = "TeamCellCollectionViewCell"
    private let memberCellId = "TeamMemberCellCollectionViewCell"
    private let opponentCellId = "OpponentTeamMemberCellCollectionViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeams()
        registerCells()
        setupCollectionViews()
        setupUI()
    }
    
    private func setupUI() {
        GameHeaderViewOutlet.layer.cornerRadius = 25
        addOpponentTeamButton.layer.cornerRadius = 16
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
        
        if let layout = yourTeamCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 69, height: 79)
        }
        
        if let layout = opponentTeamMembersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 69, height: 94)
        }
        
        if let layout = yourTeamMembersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 69, height: 94)
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
            vc.delegate = self
            present(vc, animated: true, completion: nil)
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
        
        guard opponentTeam != nil else {
            showAlert(message: "Please add an opponent team")
            return false
        }
        
        return true
    }
    
    private func createGame() {
        guard let selectedTeam = selectedTeam,
                  let opponentTeam = opponentTeam else {
                showAlert(message: "Teams are not properly selected.")
                return
            }
            
            // Instantiate AddMemberDetailsViewController
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            guard let addMemberVC = storyboard.instantiateViewController(withIdentifier: "AddMemberDetailsViewController") as? AddMemberDetailsViewController else {
//                print("Failed to instantiate AddMemberDetailsViewController")
//                return
//            }
        let addMemberVC = AddMemberDetailsViewController(nibName: "AddMemberDetailsViewController", bundle: nil  )
            
            // Pass data to AddMemberDetailsViewController
            addMemberVC.yourTeam = selectedTeam
            addMemberVC.yourTeamMembers = members
            addMemberVC.opponentTeam = opponentTeam
            addMemberVC.opponentTeamMembers = opponentMembers
            
        // Navigating to AddMemberDetailsViewController
        
        navigationController?.pushViewController(addMemberVC, animated: true)
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
    
    
    private func fetchTeams() {
        Task {
            do {
                let response: [TeamTable] = try await SupabaseManager.shared.supabase
                    .from("teams")
                    .select()
                    .execute()
                    .value
                
                Task { @MainActor in
                    print("Success Data fetched Successfully")
                    self.teams = response
                    self.yourTeamCollectionView.reloadData()
//                print(response)
//                DispatchQueue.main.async {
//                    self.yourTeamCollectionView.reloadData()
                }
                
//                await MainActor.run {
//                    print("Success Data fetched Successfully")
//                    self.yourTeamCollectionView.reloadData()
//                }
                
            } catch {
                print("Failed to fetch teams: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchTeamMembers(for teamID: UUID) {
        Task {
            do {
                let response: [TeamMembershipTable] = try await SupabaseManager.shared.supabase
                    .from("teamMembership")
                    .select()
                    .eq("teamID", value: teamID.uuidString)
                    .execute()
                    .value
                
                self.members = response
                print("Team Members: \(response)")
                
                let userIDs = response.map { $0.userID }
                fetchMemberProfiles(for: userIDs)
                
                DispatchQueue.main.async {
                    self.yourTeamMembersCollectionView.reloadData()
                }
            } catch {
                print("Failed to fetch team members: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func fetchMemberProfiles(for userIDs: [UUID]) {
        Task {
            do {
                // Convert array of UUIDs to a single comma-separated string
                let uuidString = "(" + userIDs.map { "'\($0.uuidString)'" }.joined(separator: ",") + ")"
                
                let response: [Usertable] = try await SupabaseManager.shared.supabase
                    .from("AthleteProfile")
                    .select()
                    .filter("athleteID", operator: "in", value: uuidString)
                    .execute()
                    .value
                
                print("Member Profiles: \(response)")
                // You can update the collection view to display detailed profiles if needed.
            } catch {
                print("Failed to fetch profiles: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchOpponentMembers(for teamID: UUID) {
        Task {
            do {
                let response: [TeamMembershipTable] = try await SupabaseManager.shared.supabase
                    .from("teamMembership")
                    .select()
                    .eq("teamID", value: teamID.uuidString)
                    .execute()
                    .value
                
                self.opponentMembers = response
                print("Opponent Team Members: \(response)")
                
                DispatchQueue.main.async {
                    self.opponentTeamMembersCollectionView.reloadData()
                }
            } catch {
                print("Failed to fetch opponent team members: \(error.localizedDescription)")
            }
        }
    }


    
    
}

extension CreateGameViewController: InviteDelegate {
    func didSelectTeam(_ team: TeamTable) {
        opponentTeam = team  // Assuming you only want one opponent team
        fetchOpponentMembers(for: team.teamID)
        print("Selected Opponent Team: \(team.teamName)")
    }
}

extension CreateGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case yourTeamCollectionView:
            print("Number of teams: \(teams.count)")
            return teams.count
        case yourTeamMembersCollectionView:
            return members.count
        case opponentTeamMembersCollectionView:
            print("Opponent Members Count: \(opponentMembers.count)")
            return opponentMembers.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case yourTeamCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamCellId, for: indexPath) as! TeamCellCollectionViewCell
            let team = teams[indexPath.row]
            print("Configuring cell for team: \(team.teamName)")
            cell.configure(with: teams[indexPath.row])
            return cell
            
        case yourTeamMembersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: memberCellId, for: indexPath) as! TeamMemberCellCollectionViewCell
            cell.configure(with: members[indexPath.row])
            return cell
            
        case opponentTeamMembersCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: opponentCellId, for: indexPath) as! OpponentTeamMemberCellCollectionViewCell
            let member = opponentMembers[indexPath.row]
            cell.configure(with: member)
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
            print("selected team: \(String(describing: selectedTeam))")
            selectedTeam = teams[indexPath.row]
            guard let teamID = selectedTeam?.teamID else { return }
            fetchTeamMembers(for: teamID)
            
        } else if collectionView == opponentTeamMembersCollectionView {
            // Handle selection of opponent team members
            
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
    
    
}
