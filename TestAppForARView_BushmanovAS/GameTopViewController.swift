import UIKit
import Alamofire
import Kingfisher

class GameTopViewController: UIViewController {
    @IBOutlet weak var gameTableView: UITableView!
    var top: [Top] = []
    var imageView = UIImageView()
    var network = true
    var games = RealmManager.shared.getAllTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableView.rowHeight = 200
        
        if InternetCheck.isConnectedToNetwork() {
            network = true
            RealmManager.shared.removeAll()
            
            GameTopLoader().loadGameTop { (top) in
                self.top = top
                self.gameTableView.reloadData()
            }
            
        } else {
            network = false
            games = RealmManager.shared.getAllTask()
            self.gameTableView.reloadData()
        }
    }
    
    @IBAction func rateButton(_ sender: Any) {
        RateManager.showRateConroller()
    }
}


//MARK: Ext. TableViewDelegate
extension GameTopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch network {
        case true: return top.count
        case false: return games.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameTopTableViewCell
        
        if network == true {
            let url = URL(string: top[indexPath.row].game.box.large!)
            cell.gameImage.kf.setImage(with: url)
            cell.gameName.text = top[indexPath.row].game.name
            cell.gameChannelsNumber.text = ("Каналы: \(top[indexPath.row].channels!)")
            cell.gameSpectatorsNumber.text = ("Зрители: \(top[indexPath.row].viewers!)")
            let gameTopRealm = GameTopRealm()
            gameTopRealm.name = top[indexPath.row].game.name!
            gameTopRealm.channels = top[indexPath.row].channels!
            gameTopRealm.viewers = top[indexPath.row].viewers!
            gameTopRealm.gameImageUrl = top[indexPath.row].game.box.large!
            RealmManager.shared.addTask(task: gameTopRealm)
            return cell
        } else {
            let url = URL(string: games[indexPath.row].gameImageUrl)
            cell.gameImage.kf.setImage(with: url)
            cell.gameName.text = games[indexPath.row].name
            cell.gameChannelsNumber.text = ("Каналы: \(games[indexPath.row].channels)")
            cell.gameSpectatorsNumber.text = ("Зрители: \(games[indexPath.row].viewers)")
            return cell
        }
    }
}

