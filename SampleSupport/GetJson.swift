//
//  GetJson.swift
//
//  Created by cmStudent on 2021/02/17.
//  Copyright © 2021 19cm0134. All rights reserved.
//

import UIKit

func getExhibiJson(url: String) -> [ExhibitionModel]? {
    guard let url: URLComponents = URLComponents(string: url) else { return nil }
    let semaphore = DispatchSemaphore(value: 0)
    var result: [ExhibitionModel]?
    
    let task = URLSession.shared.dataTask(with: url.url!,completionHandler:
                                            { data, response, error in
                                                do {
                                                    guard (response as? HTTPURLResponse) != nil else { return }
                                                    result = try JSONDecoder().decode( [ExhibitionModel].self, from: data!)
                                                    semaphore.signal()
                                                    print("JSONDecode処理終了")
                                                } catch (let message) {
                                                    print("URLの読み込みエラー発生")
                                                    print(message)
                                                    return
                                                }
                                            })
    task.resume()
    semaphore.wait()
    return result
}

func getCatJson(url: String) -> [CategoryModel]? {
    guard let url: URLComponents = URLComponents(string: url) else { return nil }
    let semaphore = DispatchSemaphore(value: 0)
    var result: [CategoryModel]?
    
    let task = URLSession.shared.dataTask(with: url.url!,completionHandler:
                                            { data, response, error in
                                                do {
                                                    guard (response as? HTTPURLResponse) != nil else { return }
                                                    result = try JSONDecoder().decode( [CategoryModel].self, from: data!)
                                                    semaphore.signal()
                                                    print("JSONDecode処理終了")
                                                } catch (let message) {
                                                    print("URLの読み込みエラー発生")
                                                    print(message)
                                                    return
                                                }
                                            })
    task.resume()
    semaphore.wait()
    return result
}

func getWorksJson(url: String) -> [WorksModel]? {
    guard let url: URLComponents = URLComponents(string: url) else { return nil }
    let semaphore = DispatchSemaphore(value: 0)
    var result: [WorksModel]?
    let task = URLSession.shared.dataTask(with: url.url!,completionHandler:
                                            { data, response, error in
                                                do {
                                                    guard (response as? HTTPURLResponse) != nil else { return }
                                                    result = try JSONDecoder().decode( [WorksModel].self, from: data!)
                                                    semaphore.signal()
                                                    print("JSONDecode処理終了")
                                                } catch (let message) {
                                                    print("URLの読み込みエラー発生")
                                                    print(message)
                                                    return
                                                }
                                            })
    task.resume()
    semaphore.wait()
    return result
}
