//
//  UIViewController.swift
//  MoviePinsoft
//
//  Created by burak kaya on 26/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import UIKit

extension UIViewController {

    func showTryAgainAlert(title: String, message: String, isCancelable: Bool, repeatAction: ((UIAlertAction) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if isCancelable {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        let OKAction = UIAlertAction(title: "Try Again", style: .default, handler: repeatAction)
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }

    func showAlert(title: String, message: String?){

        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion:nil)
        }
    }
}

