//
//  GopaActivityIndicator.swift
//  Gopa
//
//  Created by Santiago Lazzari on 25/08/2019.
//  Copyright © 2019 gopa. All rights reserved.
//

import UIKit

import Lottie

class MyHealthAppActivityIndicator {
    
    let lottieView = LOTAnimationView()
    let containerView = UIView()


    init(into view: UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false;
        lottieView.translatesAutoresizingMaskIntoConstraints = false;
        
        view.addSubview(containerView)
        view.bringSubviewToFront(containerView)
        self.containerView.addSubview(lottieView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", metrics: nil, views: ["view": containerView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", metrics: nil, views: ["view": containerView]))
        
        self.containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2964736729)
        
        lottieView.setAnimation(named: "lottie-search")
        lottieView.backgroundColor = UIColor.clear
        lottieView.loopAnimation = true
        
        self.containerView.addConstraints([NSLayoutConstraint(item: lottieView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0),
                                           NSLayoutConstraint(item: lottieView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0),
                                           NSLayoutConstraint(item: lottieView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140),
                                           NSLayoutConstraint(item: lottieView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 140)
            ])
        
        pause()

    }
    
    public func play() {
        containerView.isHidden = false
        lottieView.play()
    }
    
    public func pause() {
        containerView.isHidden = true
        lottieView.stop()
    }

    
}
