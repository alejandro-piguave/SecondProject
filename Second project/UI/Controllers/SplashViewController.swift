//
//  ViewController.swift
//  Second project
//
//  Created by Dev2 on 02/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import RealmSwift

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
        
        DataManager.shared.loadUsers { (result) in
            switch result {
            case .success(data: let data):
                let next = UIStoryboard(name: "Main", bundle: nil)
                guard let results = data as? Results<UserDAO>, let vc = next.instantiateInitialViewController() as? MainViewController else {
                    return
                }
                let convertedUsers = DataManager.shared.convert(from: results)
                vc.users = convertedUsers
                
                self.present(vc, animated: true, completion: nil)
            case .failure(msg: let msg):
                print(msg)
                }
            }
        
    }
}
