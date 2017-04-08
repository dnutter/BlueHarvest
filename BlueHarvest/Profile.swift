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
    
    private struct SerializeKeys {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let birthdate = "birthdate"
        static let profilePicture = "profilePicture"
        static let forceSensitive = "forceSensitive"
        static let affiliation = "affiliation"
    }
    
    init?(with dictionary: Dictionary<String, Any>) {
        guard let firstName = dictionary[SerializeKeys.firstName] as? String,
        let lastName = dictionary[SerializeKeys.lastName] as? String,
        let birthdate = dictionary[SerializeKeys.birthdate] as? String,
        let profilePicture = dictionary[SerializeKeys.profilePicture] as? String,
        let forceSensitive = dictionary[SerializeKeys.forceSensitive] as? Bool,
        let affiliationString = dictionary[SerializeKeys.affiliation] as? String,
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
        dictionary[SerializeKeys.firstName] = self.firstName
        dictionary[SerializeKeys.lastName] = self.lastName
        dictionary[SerializeKeys.birthdate] = self.birthdate
        dictionary[SerializeKeys.profilePicture] = self.profilePicture
        dictionary[SerializeKeys.forceSensitive] = self.forceSensitive
        dictionary[SerializeKeys.affiliation] = self.affiliation.rawValue
        
        return dictionary
    }

}
