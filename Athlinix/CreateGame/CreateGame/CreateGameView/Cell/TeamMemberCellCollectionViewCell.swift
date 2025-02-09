//
//  TeamMemberCellCollectionViewCell.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/31/24.
//

import UIKit

class TeamMemberCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MemberContainer: UIView!
    @IBOutlet weak var MemberAvatarOutlet: UIImageView!
    
    @IBOutlet weak var UsernameOutlet: UILabel!
    @IBOutlet weak var NameOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        MemberContainer.layer.cornerRadius = 10
        MemberContainer.clipsToBounds = true
    }
    

    func configure(with member: TeamMembershipTable) {
            // Configure your cell here
        NameOutlet.text = member.membershipID.uuidString // Assuming TeamMembership has a name property
            // Configure other UI elements based on your TeamMembership model
        }

}
