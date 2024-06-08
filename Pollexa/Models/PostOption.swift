////
////  PostOption.swift
////  Pollexa
////
////  Created by Emirhan Erdogan on 13/05/2024.
////
//
//import UIKit
//
//extension Post {
//    
//    struct Option: Decodable {
//        
//        // MARK: - Types
//        enum CodingKeys: String, CodingKey {
//            case id
//            case imageName
//        }
//        
//        // MARK: - Properties
//        let id: String
//        let image: UIImage
//        
//        // MARK: - Life Cycle
//        init(from decoder: any Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            
//            id = try container.decode(String.self, forKey: .id)
//            
//            let imageName = try container.decode(
//                String.self,
//                forKey: .imageName
//            )
//            
//            if let image = UIImage(named: imageName) {
//                self.image = image
//            } else {
//                throw DecodingError.dataCorrupted(.init(
//                    codingPath: [CodingKeys.imageName],
//                    debugDescription: "An image with name \(imageName) could not be loaded from the bundle.")
//                )
//            }
//        }
//    }
//}
import Foundation

struct PostLike: Codable {
    let postId: String
    let likedOption: String
    let timestamp: Date
}

class LikeManager {
    static let shared = LikeManager()
    
    private let likesKey = "user_likes"
    
    func saveLike(for postId: String, option: String) {
        let like = PostLike(postId: postId, likedOption: option, timestamp: Date())
        var likes = getLikes()
        likes[postId] = like
        saveLikes(likes)
    }
    
    func getLike(for postId: String) -> PostLike? {
        let likes = getLikes()
        return likes[postId]
    }
    
    func getTotalLikes(for postId: String) -> [String: Int] {
        let likes = getLikes().filter { $0.key == postId }
        var optionCounts = [String: Int]()
        
        for like in likes.values {
            optionCounts[like.likedOption, default: 0] += 1
        }
        
        return optionCounts
    }
    
    private func getLikes() -> [String: PostLike] {
        guard let data = UserDefaults.standard.data(forKey: likesKey),
              let likes = try? JSONDecoder().decode([String: PostLike].self, from: data) else {
            return [:]
        }
        return likes
    }
    
    private func saveLikes(_ likes: [String: PostLike]) {
        guard let data = try? JSONEncoder().encode(likes) else { return }
        UserDefaults.standard.set(data, forKey: likesKey)
    }
}
