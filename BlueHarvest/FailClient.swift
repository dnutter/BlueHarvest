//
//  FailClient.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/20/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

struct FailClient: APIClient {
    func retrieveProfiles(_ completion: @escaping (Error?, [Profile]) -> ()) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(3)) {
            completion(NSError(domain: "APIClient", code: 4, userInfo: ["Reason": "Unknown error"]), [])
        }
    }
}
