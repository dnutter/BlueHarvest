//
//  Client.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/20/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation
import Alamofire

struct Client: APIClient {
    
    static private let url = "https://edge.ldscdn.org/mobile/interview/directory"
    
    func retrieveProfiles(_ completion: @escaping (Error?, [Profile]) -> ()) {

        Alamofire.request(Client.url).responseJSON { response in
            if let json = response.result.value {
                let formatter = ProfileFormatter()
                if let profileList = formatter.makeProfileList(from: json) {
                    completion(nil, profileList)
                } else {
                    completion(response.error, [])
                }
            }
        }
    }
}
