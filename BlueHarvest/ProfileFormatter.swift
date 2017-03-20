//
//  ProfileFormatter.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

struct ProfileFormatter {
    
    struct ProfileKeys {
        static let individuals = "individuals"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let birthdate = "birthdate"
        static let profilePicture = "profilePicture"
        static let forceSensitive = "forceSensitive"
        static let affiliation = "affiliation"
    }
    
    func makeProfileList(from json: Any) -> [Profile]? {
        
        guard let dictionary = json as? Dictionary<String, Any>,
            let individuals = dictionary[ProfileKeys.individuals] as? [Dictionary<String, Any>] else {
                return nil
        }
        
        return individuals.map { self.makeProfile(from: $0) }.flatMap { $0 }
        
    }
    
    func makeProfile(from json: Any) -> Profile? {
        
        guard let dictionary = json as? Dictionary<String, Any>,
            let firstName = dictionary[ProfileKeys.firstName] as? String,
            let lastName = dictionary[ProfileKeys.lastName] as? String,
            let birthdate = dictionary[ProfileKeys.birthdate] as? String,
            let profilePicture = dictionary[ProfileKeys.profilePicture] as? String,
            let forceSensitive = dictionary[ProfileKeys.forceSensitive] as? Bool,
            let affiliation = dictionary[ProfileKeys.affiliation] as? String else {
                return nil
        }
        
        guard let type = Profile.Affiliation(rawValue: affiliation) else {
            return nil
        }
        
        return Profile(firstName: firstName, lastName: lastName, birthdate: birthdate, profilePicture: profilePicture, forceSensitive: forceSensitive, affiliation: type)
    }
}
