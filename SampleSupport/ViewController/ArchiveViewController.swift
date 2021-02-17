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
    
    private var category = ["産学連携", "オリジナル教材", "学生作品", "教員の創作活動", "コンテスト・競技大会", "学科横断取組み", "キャリア教育"]
    private var artwork = ["NINJA THE MONSTER", "オリジナル教材", "AIMRACING", "かりきゅらすかい", "技能五輪全国・国際大会実績", "インサニア", "キャリアサポーター"]
    private var image = ["panel01", "panel08", "panel09", "panel15", "panel16", "panel17", "panel21"]
    private var time = ["1/29 12:12", "1/29 12:21", "1/29 12:35", "1/29 12: 49", "1/29 13:00", "1/29 13:08", "1/29 13:20"]
    
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
        
        return artwork.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArchiveCell
        cell.setText(category: category[indexPath.row], name: artwork[indexPath.row], time: time[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected TableViewCell")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "detail") as! DetailedWorksViewController
        vc.setter(categoryName: category[indexPath.row], artwork: artwork[indexPath.row], imageName: image[indexPath.row])
        let nextvc = MainNavigationController(rootViewController: vc)
        nextvc.modalPresentationStyle = .fullScreen
        self.present(nextvc, animated: true, completion: nil)
    }
}
