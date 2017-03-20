//
//  Profile.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

protocol Serializable {
    func asDictionary() -> Dictionary<String, Any>
    init?(with dictionary: Dictionary<String, Any>)
}

struct Profile {
    
    enum Affiliation: String {
        case jedi = "JEDI"
        case resistance = "RESISTANCE"
        case firstOrder = "FIRST_ORDER"
        case sith = "SITH"
    }
    
    let firstName: String
    let lastName: String
    let birthdate: String
    let profilePicture: String  // URL string
    let forceSensitive: Bool
    let affiliation: Affiliation
    
}

extension Profile {
    
    func fullName() -> String {
        return "\(self.firstName) \(self.lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}

extension Profile: Serializable {
    
    struct Constants {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let birthdate = "birthdate"
        static let profilePicture = "profilePicture"
        static let forceSensitive = "forceSensitive"
        static let affiliation = "affiliation"
    }
    
    init?(with dictionary: Dictionary<String, Any>) {
        guard let firstName = dictionary[Constants.firstName] as? String,
        let lastName = dictionary[Constants.lastName] as? String,
        let birthdate = dictionary[Constants.birthdate] as? String,
        let profilePicture = dictionary[Constants.profilePicture] as? String,
        let forceSensitive = dictionary[Constants.forceSensitive] as? Bool,
        let affiliationString = dictionary[Constants.affiliation] as? String,
        let affiliation = Profile.Affiliation(rawValue: affiliationString) else {
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
        self.profilePicture = profilePicture
        self.forceSensitive = forceSensitive
        self.affiliation = affiliation
    }
    
    func asDictionary() -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        dictionary[Constants.firstName] = self.firstName
        dictionary[Constants.lastName] = self.lastName
        dictionary[Constants.birthdate] = self.birthdate
        dictionary[Constants.profilePicture] = self.profilePicture
        dictionary[Constants.forceSensitive] = self.forceSensitive
        dictionary[Constants.affiliation] = self.affiliation.rawValue
        
        return dictionary
    }

}
