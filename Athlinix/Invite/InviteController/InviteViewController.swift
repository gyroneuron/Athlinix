//
//  InviteViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/22/24.
//

import UIKit

class InviteViewController: UIViewController {
    
    
    @IBOutlet weak var InvitePeopleTableViewOutlet: UITableView!
    
    private var teams: [TeamTable] = []
    var delegate: InviteDelegate?
    
    // cell reuse id (cells that scroll out of view can be reused)
      let cellReuseIdentifier = "InivitePeopleCell"
    let arr: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        self.InvitePeopleTableViewOutlet.delegate   = self
        self.InvitePeopleTableViewOutlet.dataSource = self
        
        let nib = UINib(nibName: "InivitePeopleCellTableViewCell", bundle: nil)
        
        self.InvitePeopleTableViewOutlet.register(nib, forCellReuseIdentifier: "InivitePeopleCell")
        
        fetchTeams()
    }
    
    private func fetchTeams() {
            Task {
                do {
                    let response: [TeamTable] = try await SupabaseManager.shared.supabase
                        .from("teams")
                        .select()
                        .execute()
                        .value
                    
                    self.teams = response
                    print("Fetched Teams: \(response)")
                    
                    DispatchQueue.main.async {
                        self.InvitePeopleTableViewOutlet.reloadData()
                    }
                } catch {
                    print("Failed to fetch teams: \(error.localizedDescription)")
                }
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


extension InviteViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InivitePeopleCellTableViewCell = self.InvitePeopleTableViewOutlet.dequeueReusableCell(withIdentifier: "InivitePeopleCell") as! InivitePeopleCellTableViewCell
        let team = teams[indexPath.row]
        cell.nameLabelOutlet.text = team.teamName
        cell.dateLabelOutlet.text = "Created on: \(team.createdBy)"
        
        if let logoURL = team.teamLogo {
//                cell.logoImageOutlet.kf.setImage(with: URL(string: logoURL))  // Assuming Kingfisher for image loading
            print(!logoURL.isEmpty)
            } else {
                cell.logoImageOutlet.image = UIImage(named: "defaultTeamLogo")
            }
        cell.delegate = self
        cell.nameLabelOutlet.text = team.teamName
     return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedTeam = teams[indexPath.row]
            delegate?.didSelectTeam(selectedTeam)
            self.dismiss(animated: true, completion: nil)
        }
    
    
    
//    func addButtonTapped() {
//        print("Add button dab gaya")
//        guard let indexPath = InvitePeopleTableViewOutlet.indexPath(for: cell ) else { return }
//            let selectedTeam = teams[indexPath.row]
//            delegate?.didSelectTeam(selectedTeam)
//            print("Selected team: \(selectedTeam.teamName)")
//    }
//    
//    func logoButtonTapped() {
//        print("logo button dab gaya")
//    }
    
}

extension InviteViewController: ButtonCelldelegate {
    
    func addButtonTapped(in cell: InivitePeopleCellTableViewCell) {
        guard let indexPath = InvitePeopleTableViewOutlet.indexPath(for: cell) else { return }
        let selectedTeam = teams[indexPath.row]
        delegate?.didSelectTeam(selectedTeam)
        print("Selected team: \(selectedTeam.teamName)")
        self.dismiss(animated: true, completion: nil)
    }
    
    func logoButtonTapped(in cell: InivitePeopleCellTableViewCell) {
        print("Logo button tapped for cell at index: \(InvitePeopleTableViewOutlet.indexPath(for: cell)?.row ?? -1)")
    }
}
