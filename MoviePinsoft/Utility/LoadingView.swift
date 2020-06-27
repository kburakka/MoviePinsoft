//
//  LoadingView.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation
import UIKit

class LoadingView{
    
    private var view : UIView?
    private let backgroundLayer = CAShapeLayer()
    
    private let circleWidth : CGFloat = 10.0
    private let circleHeight : CGFloat = 10.0
    private let duration = 0.6
    
    private let cFirst = CAShapeLayer()
    private let cSecond = CAShapeLayer()
    private let cThird = CAShapeLayer()

    private var cArr = [CAShapeLayer]()
    
    init(view : UIView) {
        self.view = view
        cArr = [cFirst,cSecond,cThird]
        stopAnimation()
        setAccessibilityLabel()
        setBackground()
        setCircles()
    }
    
    private func setAccessibilityLabel(){
        cFirst.accessibilityLabel = "loading"
        cSecond.accessibilityLabel = "loading"
        cThird.accessibilityLabel = "loading"
        backgroundLayer.accessibilityLabel = "loading"
    }
    func startAnimation() {
        for (index,element) in cArr.enumerated(){
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = duration
            animation.beginTime = CACurrentMediaTime() + Double(index) * 0.2
            let toValue = UIBezierPath(ovalIn: CGRect(x: view!.center.x - CGFloat(20) + CGFloat(index * 20), y: view!.center.y - 30, width: circleWidth, height: circleHeight)).cgPath
            animation.toValue = toValue
            animation.repeatCount = HUGE
            animation.autoreverses = true
            
            element.add(animation, forKey: "round")
        }
    }
    
    func stopAnimation(){
        if let sublayers = view?.layer.sublayers{
            for index in sublayers{
                if index.accessibilityLabel == "loading"{
                    index.removeFromSuperlayer()
                }
            }
        }
    }
    
    private func setCircles() {
        for (index,element) in cArr.enumerated(){
            element.path = UIBezierPath(ovalIn: CGRect(x: view!.center.x - CGFloat(20) + CGFloat(index * 20), y: view!.center.y + 10, width: circleWidth, height: circleHeight)).cgPath
            element.fillColor = UIColor.darkGray.cgColor
            
            view!.layer.addSublayer(element)
        }
    }
    
    
    private func setBackground() {
        backgroundLayer.path = UIBezierPath(roundedRect: CGRect(x: view!.center.x - 45, y: view!.center.y - 35, width: 100, height: 70), cornerRadius: 15).cgPath
        backgroundLayer.fillColor = UIColor.darkGray.cgColor
        backgroundLayer.opacity = 0.5
        
        backgroundLayer.shadowPath = UIBezierPath(roundedRect: CGRect(x: view!.center.x - 45, y: view!.center.y - 35 , width: 100, height: 70), cornerRadius: 15).cgPath
        backgroundLayer.shadowColor = UIColor.black.cgColor
        backgroundLayer.shadowRadius = 25
        backgroundLayer.shadowOpacity = 0.6
        view!.layer.addSublayer(backgroundLayer)
    }
}
