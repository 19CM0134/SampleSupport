//
//  HomeViewController.swift
//  SampleTabBar
//
//  Created by cmStudent on 2020/12/11.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var menuBtn: UIButton!
//    private var presenter: ExhibitionPresenter!
    private var targetExhibition: [ExhibitionModel] = []
    
    private let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
//        setupExhibitionPresenter()
        setupFileManeger()
        recognitionUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.image = UIImage(named: targetExhibition[0].exhibitionTopImage)
    }
    
    // MARK: - Helpers
    
//    fileprivate func setupExhibitionPresenter() {
//        presenter = ExhibitionPresenter()
//        presenter.delegate = self
//        presenter.getExhibitionInfo()
//    }
    
    fileprivate func setupFileManeger() {
        guard let url = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
                .appendingPathComponent("exhibition.json") else {return}
        do {
            let data = try Data(contentsOf: url)
            print(String(data: data, encoding: .utf8)!)
            self.targetExhibition = try JSONDecoder().decode([ExhibitionModel].self, from: data)
            print(self.targetExhibition)
        } catch {
            print(error)
        }
    }
    
    fileprivate func recognitionUI() {
        menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuBtn.tintColor = .black
        menuBtn.addTarget(self, action: #selector(tappedMenuBtn), for: .touchUpInside)
    }
    
    // MARK: - Selecters
    
    @objc func tappedMenuBtn() {
        let vc = MenuViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - ExhibitionPresenterDelegate

//extension HomeViewController: ExhibitionPresenterDelegate {
//    func setExhibitionToScreen(_ exhibition: [ExhibitionModel]) {
//        targetExhibition = exhibition
//    }
//}
