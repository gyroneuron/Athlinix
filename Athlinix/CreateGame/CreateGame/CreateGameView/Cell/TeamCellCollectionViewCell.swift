//
//  TeamCellCollectionViewCell.swift
//  Athlinix
//
//  Created by Vivek Jaglan on 12/31/24.
//

import UIKit

class TeamCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TeamLogoOutlet: UIImageView!
    
    @IBOutlet weak var TeamNameOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with team: Teams) {
            // Configure your cell here
        TeamNameOutlet.text = team.teamName // Assuming Teams has a name property
            // Set any other properties based on your Teams model
        }

}
