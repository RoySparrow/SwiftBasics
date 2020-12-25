//
//  ImageLoader.swift
//  TestLoadImage
//
//  Created by Roy Sparrow on 2020/12/24.
//  Copyright © 2020 SparrowStudio. All rights reserved.
//

import UIKit

class ImageLoader {
    
    func loadImageFromAssets(name: String) -> UIImage? {
        let image = UIImage(named: name)
        return image
    }
    
    func loadImageFromForder(name: String, withExtension fileExtension: String = ".jpg", in forderName: String = "Sources") -> UIImage? {
        
        // 1st approach:
        // get forder url -> generate image url -> load data

//        let url = Bundle.main.url(forResource: forderName, withExtension: nil)
//        guard let forderUrl = url else { return nil }
//
//        let imagePath = forderUrl.appendingPathComponent("\(name)\(fileExtension)", isDirectory: false).path
//        guard FileManager.default.fileExists(atPath: imagePath) else { return nil }
//
//        let data = FileManager.default.contents(atPath: imagePath)
//        guard let imageData = data else { return nil }
//
//        let image = UIImage(data: imageData)
//        return image
        
        // 2nd approach:
        // get image url -> load data
        
        let url = Bundle.main.url(forResource: name, withExtension: fileExtension, subdirectory: forderName)
        guard let imageUrl = url else { return nil }

        let imagePath = imageUrl.path
        guard FileManager.default.fileExists(atPath: imagePath) else { return nil }

        let data = FileManager.default.contents(atPath: imagePath)
        guard let imageData = data else { return nil }

        let image = UIImage(data: imageData)
        return image
    }
}
