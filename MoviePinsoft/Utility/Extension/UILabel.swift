//
//  UILabel.swift
//  MoviePinsoft
//
//  Created by burak kaya on 26/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation
import UIKit

public typealias AnimationCompletion = () -> Void

extension UILabel {
    func startAnimation(duration : Double,_ completion: AnimationCompletion? = nil)
    {
        DispatchQueue.main.async {
            let shrinkDuration: TimeInterval = duration * 0.3
            
            UIView.animate(withDuration: shrinkDuration, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(), animations: {
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.5,y: 0.5)
                self.transform = scaleTransform
                
            }, completion: { finished in
                self.playZoomOutAnimation(duration: duration, completion)
            })
        }
    }
    
    private func playZoomOutAnimation(duration : Double,_ completion: AnimationCompletion? = nil)
    {
        let growDuration: TimeInterval =  duration * 0.3
        
        UIView.animate(withDuration: growDuration, animations:{
            
            self.transform = self.getZoomOutTranform()
            self.alpha = 0
            
        }, completion: { finished in
            
            self.removeFromSuperview()
            
            completion?()
        })
    }
    
    private func getZoomOutTranform() -> CGAffineTransform
    {
        let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 8, y: 8)
        return zoomOutTranform
    }
}
