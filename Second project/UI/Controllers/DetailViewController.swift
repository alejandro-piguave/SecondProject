//
//  DetailViewController.swift
//  Second project
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func deleteAction(sender: UIButton) {
        
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
