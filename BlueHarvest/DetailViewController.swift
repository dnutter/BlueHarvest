//
//  DetailViewController.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var profile: Profile?
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var birthdateLabel: UILabel!
    @IBOutlet fileprivate weak var affiliationLabel: UILabel!
    @IBOutlet fileprivate weak var forceSensitiveLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .bottom
        
        guard let profile = profile else { return }
        
        self.nameLabel.text = profile.fullName()
        self.birthdateLabel.text = "DOB: \(profile.birthdate)"
        self.forceSensitiveLabel.text = profile.forceSensitive ? "Force Sensitive" : ""
        
        let affiliationText: String
        switch profile.affiliation {
        case .jedi:
            affiliationText = "Jedi"
        case .firstOrder:
            affiliationText = "First Order"
        case .resistance:
            affiliationText = "Resistance"
        case .sith:
            affiliationText = "Sith"
        }
        self.affiliationLabel.text = "Affiliation: \(affiliationText)"

        
        if let url = URL(string: profile.profilePicture) {
            self.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile_blank"))
        }
    }

}
