import UIKit

protocol MainRoutingLogic {
    var viewController: UIViewController! { get set }
}

protocol MainRouter: MainRoutingLogic { }

class DefaultMainRouter: MainRouter {
    weak var viewController: UIViewController!
}

// MARK: - Routing Logic
extension DefaultMainRouter: MainRoutingLogic {
}
