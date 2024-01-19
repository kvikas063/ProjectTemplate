//
//  Image+Ext.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func animateImage(with image: UIImage) {
        UIView.transition(with: self,
                          duration: 0.2,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: {
            DispatchQueue.main.async {
                self.image = image
            }
        }, completion: nil)
    }

    @discardableResult
    func loadImageFromURL(urlString: String?, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        self.image = nil
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return nil
        }
        let cacheKey = NSString(string: urlString)
        if let image = imageCache.object(forKey: cacheKey) {
            self.image = image
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data,
                   let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: cacheKey)
                    completion(downloadedImage)
                }
            }
        }
        task.resume()
        return task
    }
}
