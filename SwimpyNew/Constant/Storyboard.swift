// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case ActivityViewControllerScene = "ActivityViewController"
    static func instantiateActivityViewController() -> ActivityViewController {
      guard let vc = StoryboardScene.Main.ActivityViewControllerScene.viewController() as? ActivityViewController
      else {
        fatalError("ViewController 'ActivityViewController' is not of the expected class ActivityViewController.")
      }
      return vc
    }

    case AddressDetailsViewControllerScene = "AddressDetailsViewController"
    static func instantiateAddressDetailsViewController() -> AddressDetailsViewController {
      guard let vc = StoryboardScene.Main.AddressDetailsViewControllerScene.viewController() as? AddressDetailsViewController
      else {
        fatalError("ViewController 'AddressDetailsViewController' is not of the expected class AddressDetailsViewController.")
      }
      return vc
    }

    case CartViewControllerScene = "CartViewController"
    static func instantiateCartViewController() -> CartViewController {
      guard let vc = StoryboardScene.Main.CartViewControllerScene.viewController() as? CartViewController
      else {
        fatalError("ViewController 'CartViewController' is not of the expected class CartViewController.")
      }
      return vc
    }

    case CategoriesViewControllerScene = "CategoriesViewController"
    static func instantiateCategoriesViewController() -> CategoriesViewController {
      guard let vc = StoryboardScene.Main.CategoriesViewControllerScene.viewController() as? CategoriesViewController
      else {
        fatalError("ViewController 'CategoriesViewController' is not of the expected class CategoriesViewController.")
      }
      return vc
    }

    case DealsViewControllerScene = "DealsViewController"
    static func instantiateDealsViewController() -> DealsViewController {
      guard let vc = StoryboardScene.Main.DealsViewControllerScene.viewController() as? DealsViewController
      else {
        fatalError("ViewController 'DealsViewController' is not of the expected class DealsViewController.")
      }
      return vc
    }

    case ExploreViewControllerScene = "ExploreViewController"
    static func instantiateExploreViewController() -> ExploreViewController {
      guard let vc = StoryboardScene.Main.ExploreViewControllerScene.viewController() as? ExploreViewController
      else {
        fatalError("ViewController 'ExploreViewController' is not of the expected class ExploreViewController.")
      }
      return vc
    }

    case FeaturedViewControllerScene = "FeaturedViewController"
    static func instantiateFeaturedViewController() -> FeaturedViewController {
      guard let vc = StoryboardScene.Main.FeaturedViewControllerScene.viewController() as? FeaturedViewController
      else {
        fatalError("ViewController 'FeaturedViewController' is not of the expected class FeaturedViewController.")
      }
      return vc
    }

    case FilterViewControllerScene = "FilterViewController"
    static func instantiateFilterViewController() -> FilterViewController {
      guard let vc = StoryboardScene.Main.FilterViewControllerScene.viewController() as? FilterViewController
      else {
        fatalError("ViewController 'FilterViewController' is not of the expected class FilterViewController.")
      }
      return vc
    }

    case GlobalActivityViewControllerScene = "GlobalActivityViewController"
    static func instantiateGlobalActivityViewController() -> GlobalActivityViewController {
      guard let vc = StoryboardScene.Main.GlobalActivityViewControllerScene.viewController() as? GlobalActivityViewController
      else {
        fatalError("ViewController 'GlobalActivityViewController' is not of the expected class GlobalActivityViewController.")
      }
      return vc
    }

    case InboxViewControllerScene = "InboxViewController"
    static func instantiateInboxViewController() -> InboxViewController {
      guard let vc = StoryboardScene.Main.InboxViewControllerScene.viewController() as? InboxViewController
      else {
        fatalError("ViewController 'InboxViewController' is not of the expected class InboxViewController.")
      }
      return vc
    }

    case LoginViewControllerScene = "LoginViewController"
    static func instantiateLoginViewController() -> LoginViewController {
      guard let vc = StoryboardScene.Main.LoginViewControllerScene.viewController() as? LoginViewController
      else {
        fatalError("ViewController 'LoginViewController' is not of the expected class LoginViewController.")
      }
      return vc
    }

    case NewViewControllerScene = "NewViewController"
    static func instantiateNewViewController() -> NewViewController {
      guard let vc = StoryboardScene.Main.NewViewControllerScene.viewController() as? NewViewController
      else {
        fatalError("ViewController 'NewViewController' is not of the expected class NewViewController.")
      }
      return vc
    }

    case PopularViewControllerScene = "PopularViewController"
    static func instantiatePopularViewController() -> PopularViewController {
      guard let vc = StoryboardScene.Main.PopularViewControllerScene.viewController() as? PopularViewController
      else {
        fatalError("ViewController 'PopularViewController' is not of the expected class PopularViewController.")
      }
      return vc
    }

    case ProfileActivityViewControllerScene = "ProfileActivityViewController"
    static func instantiateProfileActivityViewController() -> ProfileActivityViewController {
      guard let vc = StoryboardScene.Main.ProfileActivityViewControllerScene.viewController() as? ProfileActivityViewController
      else {
        fatalError("ViewController 'ProfileActivityViewController' is not of the expected class ProfileActivityViewController.")
      }
      return vc
    }

    case ProfileItemViewControllerScene = "ProfileItemViewController"
    static func instantiateProfileItemViewController() -> ProfileItemViewController {
      guard let vc = StoryboardScene.Main.ProfileItemViewControllerScene.viewController() as? ProfileItemViewController
      else {
        fatalError("ViewController 'ProfileItemViewController' is not of the expected class ProfileItemViewController.")
      }
      return vc
    }

    case ProfileStoreViewControllerScene = "ProfileStoreViewController"
    static func instantiateProfileStoreViewController() -> ProfileStoreViewController {
      guard let vc = StoryboardScene.Main.ProfileStoreViewControllerScene.viewController() as? ProfileStoreViewController
      else {
        fatalError("ViewController 'ProfileStoreViewController' is not of the expected class ProfileStoreViewController.")
      }
      return vc
    }

    case ProfileViewControllerScene = "ProfileViewController"
    static func instantiateProfileViewController() -> ProfileViewController {
      guard let vc = StoryboardScene.Main.ProfileViewControllerScene.viewController() as? ProfileViewController
      else {
        fatalError("ViewController 'ProfileViewController' is not of the expected class ProfileViewController.")
      }
      return vc
    }

    case SaleViewControllerScene = "SaleViewController"
    static func instantiateSaleViewController() -> SaleViewController {
      guard let vc = StoryboardScene.Main.SaleViewControllerScene.viewController() as? SaleViewController
      else {
        fatalError("ViewController 'SaleViewController' is not of the expected class SaleViewController.")
      }
      return vc
    }

    case SearchItemViewControllerScene = "SearchItemViewController"
    static func instantiateSearchItemViewController() -> SearchItemViewController {
      guard let vc = StoryboardScene.Main.SearchItemViewControllerScene.viewController() as? SearchItemViewController
      else {
        fatalError("ViewController 'SearchItemViewController' is not of the expected class SearchItemViewController.")
      }
      return vc
    }

    case SearchPeopleViewControllerScene = "SearchPeopleViewController"
    static func instantiateSearchPeopleViewController() -> SearchPeopleViewController {
      guard let vc = StoryboardScene.Main.SearchPeopleViewControllerScene.viewController() as? SearchPeopleViewController
      else {
        fatalError("ViewController 'SearchPeopleViewController' is not of the expected class SearchPeopleViewController.")
      }
      return vc
    }

    case SearchStoreViewControllerScene = "SearchStoreViewController"
    static func instantiateSearchStoreViewController() -> SearchStoreViewController {
      guard let vc = StoryboardScene.Main.SearchStoreViewControllerScene.viewController() as? SearchStoreViewController
      else {
        fatalError("ViewController 'SearchStoreViewController' is not of the expected class SearchStoreViewController.")
      }
      return vc
    }

    case SearchViewControllerScene = "SearchViewController"
    static func instantiateSearchViewController() -> SearchViewController {
      guard let vc = StoryboardScene.Main.SearchViewControllerScene.viewController() as? SearchViewController
      else {
        fatalError("ViewController 'SearchViewController' is not of the expected class SearchViewController.")
      }
      return vc
    }

    case ShopViewControllerScene = "ShopViewController"
    static func instantiateShopViewController() -> ShopViewController {
      guard let vc = StoryboardScene.Main.ShopViewControllerScene.viewController() as? ShopViewController
      else {
        fatalError("ViewController 'ShopViewController' is not of the expected class ShopViewController.")
      }
      return vc
    }

    case SortViewControllerScene = "SortViewController"
    static func instantiateSortViewController() -> SortViewController {
      guard let vc = StoryboardScene.Main.SortViewControllerScene.viewController() as? SortViewController
      else {
        fatalError("ViewController 'SortViewController' is not of the expected class SortViewController.")
      }
      return vc
    }

    case StoreProfileViewControllerScene = "StoreProfileViewController"
    static func instantiateStoreProfileViewController() -> StoreProfileViewController {
      guard let vc = StoryboardScene.Main.StoreProfileViewControllerScene.viewController() as? StoreProfileViewController
      else {
        fatalError("ViewController 'StoreProfileViewController' is not of the expected class StoreProfileViewController.")
      }
      return vc
    }

    case TabBarControllerScene = "TabBarController"
    static func instantiateTabBarController() -> TabBarController {
      guard let vc = StoryboardScene.Main.TabBarControllerScene.viewController() as? TabBarController
      else {
        fatalError("ViewController 'TabBarController' is not of the expected class TabBarController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
