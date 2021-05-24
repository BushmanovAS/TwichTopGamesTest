import UIKit
import RealmSwift



class GameRealm: Object {
    @objc dynamic var viewers = 0
    @objc dynamic var channels = 0
    @objc dynamic var name = ""
}

class RealmManager {
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    func getAllTask() -> Results<GameRealm> {
        return realm.objects(GameRealm.self)
    }
    
    func removeAll() {
        try! realm.write {
            removeAll()
        }
    }

    func addTask(task: GameRealm) {
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

