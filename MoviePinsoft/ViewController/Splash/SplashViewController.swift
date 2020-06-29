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
        self.navigationController?.delegate = self
        if Reachability.isConnectedToNetwork() {
            let _ = RemoteConfigValues.shared
            RemoteConfigValues.shared.loadingDoneCallback = setRemoteConfigValues
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
        self.navigationController?.setViewControllers([masterVC], animated: true)
    }
    
    func setRemoteConfigValues(){
        setMainText()
        setApiKey()
    }
    
    func setApiKey(){
        ProductionServer.MovieAPIKey = RemoteConfigValues.shared.getString(forKey: .api_key)
    }
    
    func setMainText(){
        self.mainText.text = RemoteConfigValues.shared.getString(forKey: .splash)

        mainText.startAnimation(duration: 3.0){
            self.presentMasterViewController()
         }
    }
}

extension SplashViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        class SplashTransition: NSObject, UIViewControllerAnimatedTransitioning {
            func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
                return 0.5
            }

            func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
                let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
                if let vc = toViewController {
                    transitionContext.finalFrame(for: vc)
                    transitionContext.containerView.addSubview(vc.view)
                    vc.view.alpha = 0.0
                    UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                    animations: {
                        vc.view.alpha = 1.0
                    },
                    completion: { finished in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    })
                } else {
                    print("FadeAnimation something went wrong!")
                }
            }
        }

        return SplashTransition()
    }
}
