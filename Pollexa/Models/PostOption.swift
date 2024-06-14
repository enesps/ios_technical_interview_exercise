
import Foundation

struct PostLike: Codable {
    let postId: String
    let likedOption: String
    let timestamp: Date
}


import CoreData
import UIKit

class LikeManager {
    static let shared = LikeManager()

    private init() {}

    private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func saveLike(for postId: String, option: String) {
        let like = Like(context: context)
        like.postId = postId
        like.optionId = option
        like.timestamp = Date()
        saveContext()
    }

    func getLike(for postId: String) -> Like? {
        let request: NSFetchRequest<Like> = Like.fetchRequest()
        request.predicate = NSPredicate(format: "postId == %@", postId)
        
        do {
            let likes = try context.fetch(request)
            return likes.last
        } catch {
            print("Failed to fetch like: \(error)")
            return nil
        }
    }

    func getTotalLikes(for postId: String) -> Int {
        let request: NSFetchRequest<Like> = Like.fetchRequest()
        request.predicate = NSPredicate(format: "postId == %@", postId)
        
        do {
            let likes = try context.fetch(request)
            return likes.count
        } catch {
            print("Failed to fetch likes: \(error)")
            return 0
        }
    }
    func getLikes(for postId: String) -> [Like] {
        let request: NSFetchRequest<Like> = Like.fetchRequest()
        request.predicate = NSPredicate(format: "postId == %@", postId)
        
        do {
            let likes = try context.fetch(request)
            return likes
        } catch {
            print("Failed to fetch likes: \(error)")
            return []
        }
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
