//
//  MainViewController.swift
//  Second project
//
//  Created by Dev2 on 03/10/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var users: Array<User>?
    
    enum DisplayMode: Int {
        case TableMode, CollectionMode
    }
    
    private var displayMode = DisplayMode.TableMode
    private let tableRefreshControl = UIRefreshControl()
    private let collectionRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplay()
    }
    
    
    @objc func onSegmentedControlValueChanged( sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            set(displayMode: .TableMode)
        case 1:
            set(displayMode: .CollectionMode)
        default:
            return
        }
    }
    private func set(displayMode newDisplayMode: DisplayMode) {
        switch newDisplayMode {
        case .CollectionMode:
            collectionView.isHidden = false
            tableView.isHidden = true
            segmentedControl.selectedSegmentIndex = 1
        case .TableMode:
            collectionView.isHidden = true
            tableView.isHidden = false            
            segmentedControl.selectedSegmentIndex = 0
        }
        self.displayMode = newDisplayMode
        saveDisplayMode()
    }
    
    private func loadDisplayMode() -> DisplayMode {
        return DisplayMode(rawValue: UserDefaults.standard.integer(forKey: "DisplayMode") )!
    }
    
    private func saveDisplayMode() {
        UserDefaults.standard.set(displayMode.rawValue, forKey: "DisplayMode")
    }
}
extension MainViewController: DeleteDelegate {
    func onUserDeleted(user: User) {
        users = users?.filter({$0.id != user.id})
        tableView.reloadData()
        collectionView.reloadData()
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    private func configureDisplay() {
        configureRefreshControllers()
        configureLists()
        
        
        segmentedControl.addTarget(self, action: #selector(MainViewController.onSegmentedControlValueChanged), for: .valueChanged)
        set(displayMode: loadDisplayMode())
    }
    
    private func configureLists() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PersonCollectionViewCell")
    }
    
    private func configureRefreshControllers() {
        tableRefreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("UPDATING_USERS", comment: ""))
        tableView.refreshControl = tableRefreshControl
        
        collectionRefreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("UPDATING_USERS", comment: ""))
        collectionView.refreshControl = collectionRefreshControl
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        DataManager.shared.forceUpdateUsers { result in
            switch result {
            case .success(data: let data):
                guard let results = data as? Array<User> else{
                    return
                }
                self.users = results

                self.tableView.reloadData()
                self.collectionView.reloadData()
                
                refreshControl.endRefreshing()
            case .failure(msg: let msg):
                print("Error: \(msg)")
                refreshControl.endRefreshing()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as? PersonTableViewCell, let user = users?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(from: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenDetail", sender: tableView.cellForRow(at: indexPath))
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as? PersonCollectionViewCell, let user = users?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configure(from: user)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - 16.0) / 2.0
        return CGSize(width: cellWidth, height:  cellWidth * 1.33)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenDetail", sender: collectionView.cellForItem(at: indexPath))
    }
}

extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {

            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let user = users?[indexPath.row] {
                    destination.user = user
                
                destination.deleteDelegate = self
            }
            
            if let cell = sender as? UICollectionViewCell,
                let indexPath = collectionView.indexPath(for: cell),
                let user = users?[indexPath.row] {
                destination.user = user
                destination.deleteDelegate = self
            }
            
        }
    }
}

