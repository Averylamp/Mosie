//
//  APIMagic.swift
//  Mosie
//
//  Created by Isaiah Turner on 8/6/16.
//  Copyright © 2016 MemeMasters. All rights reserved.
//

import Alamofire

class APIMagic {
    let MUSIXMATCH_API_KEY = "63b3335a7fe1aa6d6084fdbf53671583";
    let SPEAKER_IP = "10.20.6.202";

    func searchSpotify(query: String, closure: (results: Array<JSON>) -> Void) {
        Alamofire.request(.GET, "https://api.musixmatch.com/ws/1.1/track.search", parameters: ["apikey": MUSIXMATCH_API_KEY, "f_has_lyrics":"1", "q": query], headers: ["Accept" : "application/json"])
            .response { request, response, data, error in
                
                let json = JSON(data: data!)
                closure(results: json["message"]["body"]["track_list"].array! as Array<JSON>)
        }
    }
    func getLyrics(trackId: String, closure: (lyrics: String) -> Void) {
        Alamofire.request(.GET, "https://api.musixmatch.com/ws/1.1/track.lyrics.get", parameters: ["apikey": MUSIXMATCH_API_KEY, "track_id": trackId], headers: ["Accept" : "application/json"])
            .response { request, response, data, error in
                let json = JSON(data: data!)
                let lyrics:String? = json["message"]["body"]["lyrics"]["lyrics_body"].string
                print("Lyrics: \(json)")
                if let lyric = lyrics {
                    if lyric.characters.count == 0 {
                        return                     closure(lyrics: "NO LYRICS FOUND")

                    }
                    closure(lyrics: lyric)
                } else {
                    closure(lyrics: "FUCK NO LYRICS FOUND")
                }
        }
    }
    func playSong(spotifyId: String, closure: () -> Void) {
        Alamofire.request(.POST, "http://" + SPEAKER_IP + ":8090/select", parameters: [
            "ContentItem": [
                "source": "SPOTIFY",
                "type": "uri",
                "location": "spotify:track:" + spotifyId,
                "sourceAccount": "bosehack8"
            ]], headers: ["Accept" : "application/json"], encoding: .JSON)
            .response { request, response, data, error in
                if ((error) != nil) {
                    print("\(error)")
                }
                closure()
        }
    }
    func playPlaylist(spotifyURI: String, closure: () -> Void) {
        Alamofire.request(.POST, "http://" + SPEAKER_IP + ":8090/select", parameters: [
            "ContentItem": [
                "source": "SPOTIFY",
                "type": "uri",
                "location": spotifyURI,
                "sourceAccount": "bosehack8"
            ]], headers: ["Accept" : "application/json"], encoding: .JSON)
            .response { request, response, data, error in
                if ((error) != nil) {
                    print("\(error)")
                }
                closure()
        }
    }
    
    func isNaughty (lyrics:String) -> Array<String>? {
        
        var count = 0;
        var found = [] as [String]
        let blocked:[String] = ["fuck", "ass","bitch","dick", "damn","suck", "booty","butt", "cocaine","shit","nigga", "heroine", "murder","sex", "freak", "fucking", "fucker","motherfucker", "fucked","kill", "penis","cunt", "pussy", "thong","condom","naked", "cock","rape","porn","drugs", "death", "blood", "gemma"];
        
        //var lyrics : NSString = "Random text containing blocked words, which it should not contain. Like fuck, cunt, nigga";
        
        for word in blocked {
            if lyrics.lowercaseString.containsString(word) {
                count += 1;
                found.append(word)
            }
        }
        if(count > 0){
            print("This song contains \(found) bad words");
            return found;
        } else {
            return nil;
        }
    }
    func pause(closure: () -> Void) {
        Alamofire.request(.POST, "http://" + SPEAKER_IP + ":8090/volume", parameters: [
            "volume": 0
            ], headers: ["Accept" : "application/json"], encoding: .JSON)
            .response { request, response, data, error in
                if ((error) != nil) {
                    print("\(error)")
                }
                closure()
        }
    }
    func play(closure: () -> Void) {
        Alamofire.request(.POST, "http://" + SPEAKER_IP + ":8090/volume", parameters: [
            "volume": 40
            ], headers: ["Accept" : "application/json"], encoding: .JSON)
            .response { request, response, data, error in
                if ((error) != nil) {
                    print("\(error)")
                }
                closure()
        }
    }
}


