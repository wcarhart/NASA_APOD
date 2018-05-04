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
    
    var dateToSearch: Date
    
    init(_ dateToSearch: Date) {
        self.dateToSearch = dateToSearch
    }
    
    func parseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dateToSearch)
    }
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let date = parseDate()
        
        let query: [String: String] = [
            "api_key": "TmBqxpmHdlfIjvUBFxy7N5uQQ8hPyqapNLgWzVvI",
            "date": "\(date)"
        ]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let json = try! JSON(data: data)
                //print(json)
                let title = json["title"].string
                let description = json["explanation"].string
                let urlString = json["url"].string
                let url: URL?
                if let tempURLString = urlString {
                    url = URL(string: tempURLString)!
                } else {
                    url = nil
                }
                let copyright = json["copyright"].string
                let mediaType = json["media_type"].string
                let photoInfo = PhotoInfo(title: title, description: description, url: url, copyright: copyright, mediaType: mediaType)
                completion(photoInfo)
            }
        }
        task.resume()
    }
}
