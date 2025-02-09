//
//  AddMemberDetailsViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 1/7/25.
//

import UIKit

class AddMemberDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var yourTeam: TeamTable?
    var yourTeamMembers: [TeamMembershipTable] = []
    var opponentTeam: TeamTable?
    var opponentTeamMembers: [TeamMembershipTable] = []

    @IBOutlet weak var team2score: UILabel!
    @IBOutlet weak var team1score: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var actionButtons: [UIButton]!
    @IBOutlet weak var teamName2Label: UILabel!
    @IBOutlet weak var teamName1Label: UILabel!
    @IBOutlet weak var teamLogo2: UIImageView!
    @IBOutlet weak var teamLogo1: UIImageView!
    
    var team1Score = 0
    var team2Score = 0
    
    var team1 = Team(name: "Lakers", players: [
        Player(name: "Player 1", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 2", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 3", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 4", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 5", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0)
    ])
    
    var team2 = Team(name: "Raptors", players: [
        Player(name: "Player 1", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 2", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 3", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 4", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0),
        Player(name: "Player 5", reb: 0, ast: 0, stl: 0, foul: 0, pts: 0)
    ])
    
    var selectedAction: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        
        // Populate team1 and team2 with actual data
        initializeTeams()
        
        // Update the UI with the passed data
        updateHeaderUI()
        
    }
    
    private func initializeTeams() {
        if let yourTeam = yourTeam {
            team1 = Team(name: yourTeam.teamName, players: mapMembersToPlayers(yourTeamMembers))
        }
        
        if let opponentTeam = opponentTeam {
            team2 = Team(name: opponentTeam.teamName, players: mapMembersToPlayers(opponentTeamMembers))
        }
    }
    
    // MARK: - Helper to Convert TeamMembershipTable to Player
    private func mapMembersToPlayers(_ members: [TeamMembershipTable]) -> [Player] {
        return members.map { member in
            Player(name: member.membershipID.uuidString, reb: 0, ast: 0, stl: 0, foul: 0, pts: 0)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
                UINib(nibName: "MemberScoreTableViewCell", bundle: nil),
                forCellReuseIdentifier: "MemberScoreTableViewCell"
            )
    }
    
    private func setupUI() {
        saveButton.layer.cornerRadius = 10
        for button in actionButtons {
            button.layer.cornerRadius = 8
            button.backgroundColor = .lightGray
        }
    }
    
    private func updateHeaderUI() {
        teamName1Label.text = yourTeam?.teamName ?? "Your Team"
        teamName2Label.text = opponentTeam?.teamName ?? "Opponent Team"
        team1score.text = "\(team1Score)"
        team2score.text = "\(team2Score)"
        teamLogo1.image = UIImage(named: "team1") // Replace with your actual image names
        teamLogo2.image = UIImage(named: "team2")
        
        
//        if let yourTeamLogo = yourTeam?.teamLogoURL {
//                teamLogo1.loadImage(from: yourTeamLogo)
//            }
//            if let opponentTeamLogo = opponentTeam?.teamLogoURL {
//                teamLogo2.loadImage(from: opponentTeamLogo)
//            }
    }
    
    
    
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        // Reset all buttons to default style
        for button in actionButtons {
            button.backgroundColor = .lightGray
        }
        
        // Highlight the selected button
        sender.backgroundColor = .orange
        
        // Store the selected action
        selectedAction = sender.titleLabel?.text
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        print("Team 1 Stats: \(team1.players)")
        print("Team 2 Stats: \(team2.players)")
        print("Team 1 Score: \(team1Score), Team 2 Score: \(team2Score)")
        
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Two sections: Team 1 and Team 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? team1.players.count : team2.players.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? team1.name : team2.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberScoreTableViewCell", for: indexPath) as? MemberScoreTableViewCell else {
                return UITableViewCell()
            }
            
            let player = indexPath.section == 0 ? team1.players[indexPath.row] : team2.players[indexPath.row]
            
            // Configure the cell with real player data
            cell.configure(with: player)
            
            return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let action = selectedAction else {
            print("No action selected")
            return
        }
        
        // Get the player
        if indexPath.section == 0 {
            updatePlayer(&team1.players[indexPath.row], with: action)
            if action.contains("POINT") { team1Score += extractPoints(from: action) }
        } else {
            updatePlayer(&team2.players[indexPath.row], with: action)
            if action.contains("POINT") { team2Score += extractPoints(from: action) }
        }
        
        // Reload the table view and header UI to reflect updates
        tableView.reloadData()
        updateHeaderUI()
    }
    
    
    
    // MARK: - Player Stats Update
    private func updatePlayer(_ player: inout Player, with action: String) {
        switch action {
        case "+2 PFG":
            player.pts += 2
        case "FREE THROW":
            player.pts += 1
        case "+3 PFG":
            player.pts += 3
        case "REBOUND":
            player.reb += 1
        case "ASSIST":
            player.ast += 1
        case "STEAL":
            player.stl += 1
        case "FOUL":
            player.foul += 1
        default:
            print("Unknown action")
        }
    }
    
    private func extractPoints(from action: String) -> Int {
        if action.contains("+2") { return 2 }
        if action.contains("+3") { return 3 }
        if action.contains("FREE THROW") { return 1 }
        return 0
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

// MARK: - UIImageView
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
