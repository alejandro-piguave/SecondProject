//
//  AddUserViewController.swift
//  Second project
//
//  Created by Dev2 on 24/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation


import UIKit

class AddUserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveUser))
        
    }
    
    @objc func saveUser() {
        
    }
}
extension AddUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FirstAddCell", bundle: nil), forCellReuseIdentifier: "FirstAddCell")
        tableView.register(UINib(nibName: "SecondAddCell", bundle: nil), forCellReuseIdentifier: "SecondAddCell")
        tableView.register(UINib(nibName: "ThirdAddCell", bundle: nil), forCellReuseIdentifier: "ThirdAddCell")
        tableView.register(UINib(nibName: "FourthAddCell", bundle: nil), forCellReuseIdentifier: "FourthAddCell")
        tableView.register(UINib(nibName: "FifthAddCell", bundle: nil), forCellReuseIdentifier: "FifthAddCell")
        tableView.register(UINib(nibName: "SixthAddCell", bundle: nil), forCellReuseIdentifier: "SixthAddCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstAddCell", for: indexPath)
                as! FirstAddCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondAddCell", for: indexPath)
                as! SecondAddCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdAddCell", for: indexPath)
                as! ThirdAddCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourthAddCell", for: indexPath)
                as! FourthAddCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthAddCell", for: indexPath)
                as! FifthAddCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixthAddCell", for: indexPath)
                as! SixthAddCell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
