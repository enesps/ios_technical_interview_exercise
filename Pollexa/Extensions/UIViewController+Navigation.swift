import UIKit
extension UIViewController {
    func presentVC(withIdentifier identifier: String, from storyboardName: String) {
        guard let storyboard = UIStoryboard(name: storyboardName, bundle: nil) as UIStoryboard?,
              let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController? else {
            return
        }
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    func navigationRoute(withIdentifier identifier: String) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as UIViewController? else {
            return
        }
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
