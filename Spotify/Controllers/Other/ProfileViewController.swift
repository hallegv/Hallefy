//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Halle V` on 9/7/23.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        
        APICaller.shared.getCurrentUserProfile { res in
            switch res {
            case .success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
