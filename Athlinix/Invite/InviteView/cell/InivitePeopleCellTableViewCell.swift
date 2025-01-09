//
//  InivitePeopleCellTableViewCell.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/30/24.
//

import UIKit


@objc protocol ButtonCelldelegate: AnyObject {
    @objc func addButtonTapped()
    @objc func logoButtonTapped()
}

class InivitePeopleCellTableViewCell: UITableViewCell {
    //All Outlet
    
    @IBOutlet weak var inviteBackViewOutlet: UIView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var backViewOutlet: UIView!
    
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var nameLabelOutlet: UILabel!
    
    @IBOutlet weak var logoButtonOutlet: UIButton!
    @IBOutlet weak var logoImageOutlet: UIImageView!
    weak var delegate:ButtonCelldelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inviteBackViewOutlet.layer.cornerRadius = 20
        inviteBackViewOutlet.clipsToBounds = true
        inviteBackViewOutlet.backgroundColor = .lightGray
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.delegate?.addButtonTapped()
    }
    
    @IBAction func logoButtonAction(_ sender: Any) {
        self.delegate?.logoButtonTapped()
    }
    
    
    //All Action
    
    
}
