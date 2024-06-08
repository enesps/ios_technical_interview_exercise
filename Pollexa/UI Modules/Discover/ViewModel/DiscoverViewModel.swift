import Foundation

class DiscoverViewModel {
    
    private let postProvider = PostProvider.shared
    var posts: [Post] = []
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        postProvider.fetchAll { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
