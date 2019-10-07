//
//  ViewController.swift
//  Second project
//
//  Created by Dev2 on 02/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var animationContainer: UIView!	
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = AnimationView(name: "loading-ring")
        animationView.loopMode = .loop
        animationView.frame = animationContainer.bounds
        animationView.contentMode = .scaleAspectFit

        animationContainer.addSubview(animationView)
        animationView.play()
        
        //showNextScreen()
    }


    private func showNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let next = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = next.instantiateInitialViewController() else {
                return
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
}

