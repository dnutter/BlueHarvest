//
//  FakeClient.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/20/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

struct FakeClient: APIClient {
    
    func retrieveProfiles(_ completion: @escaping (Error?, [Profile]) -> ()) {
        
        let profileDictionary = self.fakeProfiles()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
            guard JSONSerialization.isValidJSONObject(profileDictionary) else {
                DispatchQueue.main.async {
                    completion(NSError(domain: "APIClient", code: 1, userInfo: ["Reason": "Invalid JSON"]), [])
                }
                
                return
            }
            
            let formatter = ProfileFormatter()
            if let profileList = formatter.makeProfileList(from: profileDictionary) {
                DispatchQueue.main.async {
                    completion(nil, profileList)
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(NSError(domain: "APIClient", code: 2, userInfo: ["Reason": "Could not parse"]), [])
                }
            }
        }
    }
    
    private func fakeProfiles() -> [String: Any] {
        let luke: [String: Any] = [
            "firstName": "Luke",
            "lastName": "Skywalker",
            "birthdate": "1963-05-05",
            "profilePicture": "https://upload.wikimedia.org/wikipedia/en/9/9b/Luke_Skywalker.png",
            "forceSensitive": true,
            "affiliation": "JEDI"
        ]
        
        let vader: [String: Any] = [
            "firstName": "Darth",
            "lastName": "Vader",
            "birthdate": "1947-07-13",
            "profilePicture": "https://upload.wikimedia.org/wikipedia/en/7/76/Darth_Vader.jpg",
            "forceSensitive": true,
            "affiliation": "SITH"
        ]
        
        let han: [String: Any ] = [
            "firstName": "Han",
            "lastName": "Solo",
            "birthdate": "1956-08-22",
            "profilePicture": "https://upload.wikimedia.org/wikipedia/en/b/be/Han_Solo_depicted_in_promotional_image_for_Star_Wars_%281977%29.jpg",
            "forceSensitive": false,
            "affiliation": "RESISTANCE"
        ]
        
        let leia: [String: Any] = [
            "firstName": "Leia",
            "lastName": "Organa",
            "birthdate": "1963-05-05",
            "profilePicture": "https://upload.wikimedia.org/wikipedia/en/1/1b/Princess_Leia%27s_characteristic_hairstyle.jpg",
            "forceSensitive": true,
            "affiliation": "RESISTANCE"
        ]
        
        return ["individuals": [luke, han, leia, vader]]
    }
}
