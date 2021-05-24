import Foundation

struct GameTop: Decodable {
    var total: Int?
    var top: [Top]
}

struct Top: Decodable {
    var game: Game
    var viewers: Int?
    var channels: Int?
}

struct Game: Decodable {
    var name: String?
    var _id: Int?
    var giantbomb_id: Int?
    var box: Box
    var logo: Logo
    var localized_name: String?
    var locale: String?
}

struct Box: Decodable {
    var large: String?
    var medium: String?
    var small: String?
    var template: String?
}

struct Logo: Decodable {
    var large: String?
    var medium: String?
    var small: String?
    var template: String?
}
