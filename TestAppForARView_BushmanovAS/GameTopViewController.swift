import UIKit
import Alamofire
import Kingfisher

class GameTopViewController: UIViewController {
    @IBOutlet weak var gameTableView: UITableView!
    var top: [Top] = []
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableView.rowHeight = 200
        
        GameTopLoader().loadGameTop { (top) in
            self.top = top
            self.gameTableView.reloadData()
        }
    }
}



extension GameTopViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return top.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameTopTableViewCell
        let url = URL(string: top[indexPath.row].game.box.large!)
        cell.gameImage.kf.setImage(with: url)
        cell.gameName.text = top[indexPath.row].game.name
        cell.gameChannelsNumber.text = ("Каналы: \(String(top[indexPath.row].channels!))")
        cell.gameSpectatorsNumber.text = ("Зрители: \(String(top[indexPath.row].viewers!))")
        return cell
    }
}

