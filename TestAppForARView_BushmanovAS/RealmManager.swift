import UIKit
import RealmSwift



class GameTopRealm: Object {
    @objc dynamic var viewers = 0
    @objc dynamic var channels = 0
    @objc dynamic var name = ""
    @objc dynamic var gameImageUrl = ""
}

class RealmManager {
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    func getAllTask() -> Results<GameTopRealm> {
        return realm.objects(GameTopRealm.self)
    }
    
    func removeAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }

    func addTask(task: GameTopRealm) {
        try! realm.write {
            realm.add(task)
        }
    }

    func deleteTask(task: Object) {
        try! realm.write {
            realm.delete(task)
        }
    }
}

