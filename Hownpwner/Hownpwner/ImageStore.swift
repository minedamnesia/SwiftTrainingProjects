//
//  ImageStore.swift
//  Hownpwner
//
//  Created by Kelly Yamamoto on 10/28/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
class ImageStore {
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.objectForKey(key) as? UIImage
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObjectForKey(key)
    }
    
}
