//
//  APIMagic.swift
//  Mosie
//
//  Created by Isaiah Turner on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import Alamofire

class APIMagic {
    func searchSpotify(query: String, closure: (results: Array<String>) -> Void) {
        Alamofire.request(.GET, "https://api.spotify.com/v1/search", parameters: ["q": query])
            .validate(contentType: ["application/json"])
            .response { request, response, data, error in
                print("\(data!)")
        }
    }
}