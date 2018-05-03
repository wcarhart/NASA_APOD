//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Will Carhart on 5/3/18.
//  Copyright © 2018 Will Carhart. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
