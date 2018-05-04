//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    var mediaType: String
    
    init(title: String, description: String, url: URL, copyright: String?, mediaType: String) {
        self.title = title
        self.description = description
        self.url = url
        self.mediaType = mediaType
        guard let copyright = copyright else { self.copyright = nil; return }
        self.copyright = copyright
    }
}
