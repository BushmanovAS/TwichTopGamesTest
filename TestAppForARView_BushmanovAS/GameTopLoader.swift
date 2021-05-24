import Foundation
import Alamofire

class GameTopLoader {
    
    func loadGameTop(completion: @escaping ([Top]) -> Void) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.twitchtv.v5+json",
            "Client-ID": "sd4grh0omdj9a31exnpikhrmsu3v46",
            "limit": "50"
        ]
        
        AF
            .request("https://api.twitch.tv/kraken/games/top", headers: headers)
            .responseDecodable(of: GameTop.self) { (response) in
                 
                guard let gameTop = response.value else { return }
                
                completion(gameTop.top)
        }
    }
}
