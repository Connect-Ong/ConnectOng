//
//  Persistence.swift
//  ConnectOng
//
//  Created by Alley Pereira on 25/08/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    static var singleton: ImageLoader = ImageLoader()
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
//    private func getIncidentsFileManager() {
//        let tasks = ManageFileTasks.readMealDataFromFile()
//
//    }
    
    func obtainImage(imagePath: String, completionHandler: @escaping (UIImage) -> Void) {

        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let placeholder = UIImage()
            DispatchQueue.main.async {
                completionHandler(placeholder)
            }
            let url: URL! = URL(string: imagePath)
            task = session.downloadTask(
                with: url,
                completionHandler: { (location, _, error) in
                    if error != nil { return }
                    if let data = try? Data(contentsOf: location!),
                        let img: UIImage = UIImage(data: data) {
                        self.cache.setObject(img, forKey: imagePath as NSString)
                        DispatchQueue.main.async {
                            completionHandler(img)
                        }
                }
            })
            task.resume()
        }
        
    }
}
