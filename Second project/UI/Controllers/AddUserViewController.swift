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
    weak var updateDelegate: UpdateDelegate?
    private var cells = Dictionary<String,UITableViewCell>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("SAVE", comment: ""), style: .plain, target: self, action: #selector(saveUser))
    }
    
    @objc func saveUser() {
        guard let first = cells[FirstAddCell.typeName] as? FirstAddCell,
            let second = cells[SecondAddCell.typeName] as? SecondAddCell,
            let third = cells[ThirdAddCell.typeName] as? ThirdAddCell,
            let fourth = cells[FourthAddCell.typeName] as? FourthAddCell,
            let fifth = cells[FifthAddCell.typeName] as? FifthAddCell,
            let sixth = cells[SixthAddCell.typeName] as? SixthAddCell
        else {
            return
        }
        
        if let firstName = first.firstNameTF.text,
            let lastName = first.lastNameTF.text,
        //let imgLink = first.userIV.description,
            let email = second.emailTF.text,
            let cellphone = second.cellPhoneTF.text,
            let  housephone = second.housePhoneTF.text,
            let gender = third.getGender(),
            let country = fifth.selectedCountry,
            let city = fifth.cityTF.text,
            let streetName = fifth.streetNameTF.text,
            let streetNumberText = fifth.streetNumberTF.text,
            let streetNumber = Int(streetNumberText),
            let latitudeText = sixth.latitudeTF.text,
            let longitudeText = sixth.longitudeTF.text,
            let latitude = Double(latitudeText),
            let longitude = Double(longitudeText) {
            
            let dob = fourth.datePicker.date
            
            let newUser = UserDAO(uuid: "",
                                  avatar: nil,
                                  title: nil,
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  phone: housephone,
                                  cell: cellphone,
                                  gender: gender,
                                  birthdate: dob,
                                  country: country.name,
                                  city: city,
                                  streetName: streetName,
                                  streetNumber: streetNumber,
                                  nationality: country.code,
                                  latitude: latitude,
                                  longitude: longitude)
            
            DispatchQueue.global(qos: .background).async {
                DatabaseManager.shared.save(user: newUser)
                DataManager.shared.user(id: newUser.uuid, completion: { result in
                    switch result {
                    case .success(data: let data):
                        if let user = data as? User {
                            DispatchQueue.main.async {
                                self.updateDelegate?.onUserAdded(user: user)
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    default:
                        return
                    }
                })
            }
        } else {
            showWarningDialog()
        }
    }
    
    private func showWarningDialog() {
        let alertController = UIAlertController(title: NSLocalizedString("WARNING", comment: ""),
                                                message: NSLocalizedString("MISSING_INFO_MSG", comment: ""),
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("ACCEPT", comment: ""), style: .default, handler: nil))
        present(alertController, animated: true)
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        return 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstAddCell", for: indexPath)
                as! FirstAddCell
            cells[FirstAddCell.typeName] = cell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondAddCell", for: indexPath)
                as! SecondAddCell
            cells[SecondAddCell.typeName] = cell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdAddCell", for: indexPath)
                as! ThirdAddCell
            cells[ThirdAddCell.typeName] = cell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourthAddCell", for: indexPath)
                as! FourthAddCell
            cells[FourthAddCell.typeName] = cell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthAddCell", for: indexPath)
                as! FifthAddCell
            cells[FifthAddCell.typeName] = cell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixthAddCell", for: indexPath)
                as! SixthAddCell
            cells[SixthAddCell.typeName] = cell
            return cell
        default:
            return UITableViewCell()
        }
    }
}
