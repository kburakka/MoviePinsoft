//
//  SplashViewController.swift
//  MoviePinsoft
//
//  Created by burak kaya on 26/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var mainText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            mainText.startAnimation(duration: 3.0){
                self.presentMasterViewController()
            }
        }else{
            self.showTryAgainAlert(title: "Error", message: "Please check your internet connection.", isCancelable: false) { (_) in
                self.viewDidLoad()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func presentMasterViewController(){
        guard let masterVC = self.storyboard?.instantiateViewController(withIdentifier: "MasterViewController") else { return }
        self.navigationController?.setViewControllers([masterVC], animated: false)
    }
}
