//
//  ViewModel.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/19/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import UIKit

protocol ViewModelDelegate: class {
    func viewModelDidUpdate(_ viewModel: ViewModel)
}

class ViewModel {

    weak var delegate: ViewModelDelegate?
    var profiles = [Profile]() // Model

    private var client: APIClient!
    
    init() {
        self.client = Client()        
        self.profiles = DataStore.shared.unarchive()
    }
    
    func update() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.client.retrieveProfiles() { error, profiles in
            if let error = error {
                print(error)
            } else {
                self.profiles = profiles
                DataStore.shared.archive(profiles: self.profiles)
                self.delegate?.viewModelDidUpdate(self)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }

    }
    
}
