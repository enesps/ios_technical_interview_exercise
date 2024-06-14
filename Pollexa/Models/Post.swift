
import Foundation

// MARK: - PostElement
struct Post: Codable {
    let id: String
    let createdAt: Date
    let content: String
    let options: [Option]
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case content, options, user
    }
}

// MARK: - Option
struct Option: Codable {
    let id: ID
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageName
    }
}

enum ID: String, Codable {
    case option1 = "option_1"
    case option2 = "option_2"
}

// MARK: - User
struct User: Codable {
    let id, username, imageName: String

    enum CodingKeys: String, CodingKey {
        case id, username
        case imageName
    }
}


