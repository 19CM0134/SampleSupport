//
//  ArchiveViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/19.
//

import UIKit

class ArchiveViewController: UIViewController {
    
    // MARK: -  Properties
    
    private var tableView = UITableView()
    private let reuseIdentifier = "ArchiveCell"
    private var archiveHeader   = ArchiveHeader()
    private var getId: [Int] = []
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureTableView()
        getId = UserDefaults.standard.array(forKey: "id") as! [Int]
    }
    
    // MARK: - Helpers
    
    fileprivate func configureTableView() {
        tableView.register(ArchiveCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = archiveHeader
        archiveHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.rowHeight = 70
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArchiveCell
        cell.setId(id: getId[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "detail") as! DetailedWorksViewController
        vc.setter(id: getId[indexPath.row])
        let nextvc = MainNavigationController(rootViewController: vc)
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc, animated: true, completion: nil)
    }
}
