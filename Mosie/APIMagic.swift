//
//  APIMagic.swift
//  Mosie
//
//  Created by Isaiah Turner on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import Alamofire

class APIMagic {
    func searchSpotify(query: String, closure: (results: Array<JSON>) -> Void) {
        Alamofire.request(.GET, "https://api.musixmatch.com/ws/1.1/track.search", parameters: ["apikey": "63b3335a7fe1aa6d6084fdbf53671583", "f_has_lyrics":"1", "q": query], headers: ["Accept" : "application/json"])
            .response { request, response, data, error in
                
                let json = JSON(data: data!)
                closure(results: json["message"]["body"]["track_list"].array! as Array<JSON>)
        }
    }
    func getLyrics(trackId: String, closure: (lyrics: String) -> Void) {
        Alamofire.request(.GET, "https://api.musixmatch.com/ws/1.1/track.lyrics.get", parameters: ["apikey": "63b3335a7fe1aa6d6084fdbf53671583", "track_id": trackId], headers: ["Accept" : "application/json"])
            .response { request, response, data, error in
                let json = JSON(data: data!)
                let lyrics:String? = json["message"]["body"]["lyrics"]["lyrics_body"].string
                if let lyric = lyrics {
                    closure(lyrics: lyric)
                } else {
                    closure(lyrics: "FUCK NO LYRICS FOUND")
                }
        }
    }
    func playSong(spotifyId: String) {
        Alamofire.request(.POST, "http://10.20.6.202:8090/select", parameters: [
            "ContentItem": [
                "source": "SPOTIFY",
                "type": "uri",
                "location": "spotify:track:" + spotifyId,
                "sourceAccount": "bosehack8"
            ]], headers: ["Accept" : "application/json"], encoding: .JSON)
            .response { request, response, data, error in
                print("\(response)")
                print("\(error)")
        }
    }
}


