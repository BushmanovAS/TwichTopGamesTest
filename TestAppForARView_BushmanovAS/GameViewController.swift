//
//  ViewController.swift
//  TestAppForARView_BushmanovAS
//
//  Created by Антон Бушманов on 19.05.2021.
//

import UIKit
import Alamofire

class GameViewController: UIViewController {

    var viewers: [Int] = []
    var channels: [Int] = []
    var names: [String] = []
    var imgUrl: [String] = []
    var images: [UIImage] = []
    let games = GameRealm()
    var internet = true
    
    
    @IBOutlet weak var gameTableView: UITableView!
    let urlString = "https://api.twitch.tv/kraken/games/top"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableView.rowHeight = 200
        
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.twitchtv.v5+json",
            "Client-ID": "sd4grh0omdj9a31exnpikhrmsu3v46",
            "limit": "10"
        ]
        
        AF.request("https://api.twitch.tv/kraken/games/top", headers: headers).responseJSON { response in
            print(response)
            if response != nil {
                self.internet = true
                RealmService.shared.removeAll()
                
                if let objects = response.value,
                   let jsonDict = objects as? NSDictionary {                
                    let top = jsonDict["top"] as! NSArray
                    var games: [NSDictionary] = []
                    var boxes: [NSDictionary] = []
                                
                    for i in 0..<top.count {
                        let nsarr = top[i] as! NSDictionary
                        let viewers = nsarr["viewers"] as! Int                    
                        let channels = nsarr["channels"] as! Int
                        let game = nsarr["game"] as! NSDictionary
                        self.viewers.append(viewers)
                        self.channels.append(channels)
                        games.append(game)
                
                    }
                                
                    for i in 0..<games.count {
                        let nsarr = games[i]
                        let name = nsarr["name"] as! String
                        let box = nsarr["box"] as! NSDictionary
                        self.names.append(name)
                        boxes.append(box)
                    }
                
                    for i in 0..<boxes.count {
                        let nsarr = boxes[i]
                        let medium = nsarr["medium"] as! String
                        let url = URL(string: medium)
                        let data = try? Data(contentsOf: url!)
                        self.images.append(UIImage(data: data!)!)                    
                        self.imgUrl.append(medium)
                    }
                    
                    self.gameTableView.reloadData()
                                
                    for i in 0..<self.names.count {
                        self.games.channels = self.channels[i]
                        self.games.name = self.names[i]
                        self.games.viewers = self.viewers[i]
                
                    }
                
            
                }
            } else {
                RealmService.shared.getAllTask()
                self.internet = false
            }
        }

    }
}



extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameTableViewCell
        
        if internet {
            cell.gameName.text = self.names[indexPath.row]
            cell.gameChannelsNumber.text = "Количество каналов: \(self.channels[indexPath.row])"
            cell.gameSpectatorsNumber.text = "Количесвто зрителей: \(self.viewers[indexPath.row]) "
            cell.gameImage.image = self.images[indexPath.row]
        } else {
            cell.gameName.text = games.name
            cell.gameChannelsNumber.text = String(games.channels)
            cell.gameSpectatorsNumber.text = String(games.viewers)
        }
        return cell
    }
}

