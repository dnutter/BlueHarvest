//
//  APIClient.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import Foundation

protocol APIClient {
    func retrieveProfiles(_ completion: @escaping (_ error: Error?, _ profiles: [Profile])->())
}
