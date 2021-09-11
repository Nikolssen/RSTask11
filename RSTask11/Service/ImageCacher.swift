//
//  ImageCacher.swift
//  RSTask11
//
//  Created by Admin on 11.09.2021.
//

import Foundation
import UIKit
protocol ImageCacherType {
    func loadImage(urlString: String, completion: @escaping (UIImage)-> Void)
}

class ImageCacher: ImageCacherType {
    private let imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(urlString: String, completion: @escaping (UIImage)-> Void) {
        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            completion(cachedImage)
            return
        }
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url){[weak self]
            data, _, _
            in
            DispatchQueue.main.async {
                guard let data = data, let downloadedImage = UIImage(data: data) else {return}
                self?.imageCache.setObject(downloadedImage, forKey: key)
                completion(downloadedImage)
            }
        }
        task.resume()
    }
}
