//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoInfoController {
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query: [String: String] = [
            "api_key": "TmBqxpmHdlfIjvUBFxy7N5uQQ8hPyqapNLgWzVvI"
        ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try! JSON(data: data)
                print(json)
                let title = json["title"].string!
                let description = json["explanation"].string!
                let urlString = json["url"].string!
                let url = URL(string: urlString)!
                let copyright = json["copyright"].string
                let mediaType = json["media_type"].string!
                let photoInfo = PhotoInfo(title: title, description: description, url: url, copyright: copyright, mediaType: mediaType)
                completion(photoInfo)
            }
        }
        task.resume()
    }
}
