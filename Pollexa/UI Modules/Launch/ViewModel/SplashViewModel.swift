import Foundation

class SplashViewModel {
    // Navigation handler type
    var navigateToMainScreenHandler: (() -> Void)?
    
    func start() {
        // Simulating a delay before navigating
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToMainScreenHandler?()
        }
    }
}
