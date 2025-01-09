//
//  InviteViewController.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/22/24.
//

import UIKit

class InviteViewController: UIViewController,ButtonCelldelegate {


    @IBOutlet weak var InvitePeopleTableViewOutlet: UITableView!
    
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
        return arr.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:InivitePeopleCellTableViewCell = self.InvitePeopleTableViewOutlet.dequeueReusableCell(withIdentifier: "InivitePeopleCell") as! InivitePeopleCellTableViewCell
        
        cell.delegate = self
     return cell
    }
    func addButtonTapped() {
        print("Add button dab gaya")
    }
    
    func logoButtonTapped() {
        print("logo button dab gaya")
    }
    
}
