//
//  DetailViewController.swift
//  Second project
//
//  Created by Dev2 on 16/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    weak var updateDelegate: UpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    @IBAction func deleteAction(sender: UIButton) {
        let alertController = UIAlertController(title: NSLocalizedString("WARNING", comment: ""),
                                                message: String.localizedStringWithFormat(NSLocalizedString("WARNING_ALERT_MESSAGE", comment: ""), user?.firstName ?? ""),
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: .default, handler: nil))
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("DELETE", comment: ""), style: .destructive, handler: { (UIAlertAction) in
            
            guard let realUser = self.user else {
                return
            }
            DispatchQueue.global(qos: .background).async {
                DatabaseManager.shared.delete(id: realUser.id)
                DispatchQueue.main.async {
                    self.updateDelegate?.onUserDeleted(user: realUser)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        
        present(alertController, animated: true)
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        tableView.register(UINib(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdTableViewCell")
        tableView.register(UINib(nibName: "FourthTableViewCell", bundle: nil), forCellReuseIdentifier: "FourthTableViewCell")
        tableView.register(UINib(nibName: "FifthTableViewCell", bundle: nil), forCellReuseIdentifier: "FifthTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user == nil ? 0:5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let realUser = user {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath)
                    as! FirstTableViewCell
                cell.configure(from: realUser)
                return cell

            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath)
                    as! ThirdTableViewCell
                cell.configure(from: realUser)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FourthTableViewCell", for: indexPath)
                    as! FourthTableViewCell
                cell.configure(from: realUser)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath)
                    as! SecondTableViewCell
                cell.configure(from: realUser)
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FifthTableViewCell", for: indexPath)
                    as! FifthTableViewCell
                cell.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
                return cell

            default:
                return UITableViewCell()
            }
        } else {
           return UITableViewCell()
        }
    }
    

}
