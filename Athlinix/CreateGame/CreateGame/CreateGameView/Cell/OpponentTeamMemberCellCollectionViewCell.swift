//
//  OpponentTeamMemberCellCollectionViewCell.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/31/24.
//

import UIKit

class OpponentTeamMemberCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var NameOutlet: UILabel!
    @IBOutlet weak var UsernameOutlet: UILabel!
    @IBOutlet weak var ProfilePicOutlet: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        ProfilePicOutlet.layer.cornerRadius = ProfilePicOutlet.frame.height / 2
        // Initialization code
    }
    
    func configure(with member: TeamMembershipTable) {
            // Configure your cell here
        NameOutlet.text = member.membershipID.uuidString // Assuming TeamMembership has a name property
            // Configure other UI elements based on your TeamMembership model
        }

}
