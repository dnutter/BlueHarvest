//
//  ViewController.swift
//  BlueHarvest
//
//  Created by David Nutter on 3/11/17.
//  Copyright © 2017 David Nutter. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        
        self.viewModel.delegate = self
        self.viewModel.update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let detailViewController = segue.destination as? DetailViewController,
                let cell = sender as? IndividualCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            
            let profile = viewModel.profiles[indexPath.row]
            detailViewController.profile = profile
        }
    }

}

extension ViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndividualCell.identifier) as! IndividualCell
        let item = self.viewModel.profiles[indexPath.row]
        
        cell.nameLabel.text = item.fullName()
        
        if let url = URL(string: item.profilePicture) {
            cell.profileImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile_blank"))
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension ViewController: ViewModelDelegate {
    func viewModelDidUpdate(_ viewModel: ViewModel) {
        self.tableView.reloadData()
    }
}
