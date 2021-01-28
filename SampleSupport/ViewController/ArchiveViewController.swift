//
//  ArchiveViewController.swift
//  ExhibitionSup
//
//  Created by cmStudent on 2021/01/19.
//

import UIKit

// 履歴画面(TableView)
class ArchiveViewController: UIViewController {
    
    // MARK: -  Properties
    private var category = ["オリジナル教材", "キャリア教育", "キャリア教育", "キャリア教育", "キャリア教育", "キャリア教育", "コンテスト・競技大会", "学生作品"]
    private var artwork = ["オリジナル教材", "キャリアサポーター", "スポーツフェスティバル", "学生自治会・地域貢献活動", "日専祭", "留学生サポートについて", "技能五輪全国大会・国際大会での実績", "ART SCREEN"]
    private var image = ["WS000027", "WS000028", "WS000029", "WS000030", "WS000032", "WS000033", "WS000031", "WS000034"]
    
    private var tableView = UITableView()
    private let reuseIdentifier = "ArchiveCell"
    private var archiveHeader = ArchiveHeader()
    
    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureTableView()
    }
    
    // MARK: - Helpers
    
    fileprivate func configureTableView() {
        tableView.register(ArchiveCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = archiveHeader
        archiveHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.delegate = self
        tableView.dataSource = self
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
        
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArchiveCell
        cell.setText(category: category[indexPath.row], name: artwork[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected TableViewCell")
        let vc = DetailedWorksViewController()
        vc.setter(categoryName: category[indexPath.row], artwork: artwork[indexPath.row], imageName: image[indexPath.row])
        let nextvc = MainNavigationController(rootViewController: vc)
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc, animated: true, completion: nil)
    }
}
