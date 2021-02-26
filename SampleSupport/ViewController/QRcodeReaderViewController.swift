//
//  QRcodeReaderViewController.swift
//  ExhibitionSupporter
//
//  Created by cmStudent on 2020/12/24.
//

import UIKit
import MercariQRScanner

class QRcodeReaderViewController: UIViewController {
    
    // MARK: - Properties
    
    private var exhibition: [ExhibitionModel]?
    private var category  : [CategoryModel]?
    private var works     : [WorksModel]?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setQRcode()
    }
    
    private func setQRcode() {
        let qrScannerView = QRScannerView(frame: view.bounds)
        // Customize
        qrScannerView.focusImage = UIImage(named: "scan_qr_focus")
        qrScannerView.focusImagePadding = 8.0
        qrScannerView.animationDuration = 0.5
        qrScannerView.configure(delegate: self)
        view.addSubview(qrScannerView)
        qrScannerView.startRunning()
    }
    
    private func downloadExhibi(url: String) {
        exhibition = getExhibiJson(url: url)
        if let exhibi = exhibition {
            let fileManager = FileManager.default
            guard let url = try? fileManager.url(for: .documentDirectory,
                                                 in: .userDomainMask,
                                                 appropriateFor: nil,
                                                 create: true)
                    .appendingPathComponent("exhibition.json") else  {return}
            let data = try! JSONEncoder().encode(exhibi)
            do {
                try data.write(to: url)
            } catch let error {
                print(error)
            }
            print("exhibition保存成功")
        }
    }
    
    private func downloadCat(url: String) {
        category = getCatJson(url: url)
        if let cat = category {
            let fileManager = FileManager.default
            guard let url = try? fileManager.url(for: .documentDirectory,
                                                 in: .userDomainMask,
                                                 appropriateFor: nil,
                                                 create: true)
                    .appendingPathComponent("category.json") else  {return}
            let data = try! JSONEncoder().encode(cat)
            do {
                try data.write(to: url)
            } catch let error {
                print(error)
            }
            print("category保存成功")
        }
    }
    
    private func downloadWorks(url: String) {
        works = getWorksJson(url: url)
        if let info = works {
            let fileManager = FileManager.default
            guard let url = try? fileManager.url(for: .documentDirectory,
                                                 in: .userDomainMask,
                                                 appropriateFor: nil,
                                                 create: true)
                    .appendingPathComponent("works.json") else  {return}
            let data = try! JSONEncoder().encode(info)
            do {
                try data.write(to: url)
            } catch let error {
                print(error)
            }
            print("works保存成功")
        }
    }
}

// MARK: - QRScannerViewDelegate

extension QRcodeReaderViewController: QRScannerViewDelegate {
    
    // Success
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        if !code.contains("http") || !code.contains("\\") {
            let alert = UIAlertController(
                title: "展示会情報を読み取れませんでした",
                message: "読み取ったQRcodeは展示会情報のものではありません",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                                title: "OK",
                                style: .default,
                                handler: {_ in
                                    self.dismiss(animated: true,
                                                 completion: nil)
                                }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let idx = code.index(before: code.firstIndex(of: "\\")!)
        let idx1 = code.index(after: code.firstIndex(of: "\\")!)
        let idx2 = code.lastIndex(of: "\\")
        let idx3 = code.index(after: code.lastIndex(of: "\\")!)
        
        let url1 = code[...idx]
        let url2 = code[idx1..<idx2!]
        let url3 = code.suffix(from: idx3)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "読み取り成功",
                                          message: "ダウンロードを開始しますか？",
                                          preferredStyle: .actionSheet)
            let action = UIAlertAction(
                title: "ダウンロードを開始する",
                style: .default,
                handler: {
                    (action: UIAlertAction!) in
                    self.downloadExhibi(url: String(url1))
                    self.downloadCat(url: String(url2))
                    self.downloadWorks(url: String(url3))
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(identifier: "tab") as! MainTabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                })
            let close = UIAlertAction(title: "キャンセル",
                                      style: .cancel,
                                      handler: {_ in
                                        self.dismiss(animated: true, completion: nil)
                                      })
            alert.addAction(action)
            alert.addAction(close)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Error
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
}
