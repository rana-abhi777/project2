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

    static func initialViewController() -> InitialNavigationViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? InitialNavigationViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case activityViewControllerScene = "ActivityViewController"
    static func instantiateActivityViewController() -> ActivityViewController {
      guard let vc = StoryboardScene.Main.activityViewControllerScene.viewController() as? ActivityViewController
      else {
        fatalError("ViewController 'ActivityViewController' is not of the expected class ActivityViewController.")
      }
      return vc
    }

    case addressDetailsViewControllerScene = "AddressDetailsViewController"
    static func instantiateAddressDetailsViewController() -> AddressDetailsViewController {
      guard let vc = StoryboardScene.Main.addressDetailsViewControllerScene.viewController() as? AddressDetailsViewController
      else {
        fatalError("ViewController 'AddressDetailsViewController' is not of the expected class AddressDetailsViewController.")
      }
      return vc
    }

    case cartViewControllerScene = "CartViewController"
    static func instantiateCartViewController() -> CartViewController {
      guard let vc = StoryboardScene.Main.cartViewControllerScene.viewController() as? CartViewController
      else {
        fatalError("ViewController 'CartViewController' is not of the expected class CartViewController.")
      }
      return vc
    }

    case categoriesViewControllerScene = "CategoriesViewController"
    static func instantiateCategoriesViewController() -> CategoriesViewController {
      guard let vc = StoryboardScene.Main.categoriesViewControllerScene.viewController() as? CategoriesViewController
      else {
        fatalError("ViewController 'CategoriesViewController' is not of the expected class CategoriesViewController.")
      }
      return vc
    }

    case categoryProductsViewControllerScene = "CategoryProductsViewController"
    static func instantiateCategoryProductsViewController() -> CategoryProductsViewController {
      guard let vc = StoryboardScene.Main.categoryProductsViewControllerScene.viewController() as? CategoryProductsViewController
      else {
        fatalError("ViewController 'CategoryProductsViewController' is not of the expected class CategoryProductsViewController.")
      }
      return vc
    }

    case dealsViewControllerScene = "DealsViewController"
    static func instantiateDealsViewController() -> DealsViewController {
      guard let vc = StoryboardScene.Main.dealsViewControllerScene.viewController() as? DealsViewController
      else {
        fatalError("ViewController 'DealsViewController' is not of the expected class DealsViewController.")
      }
      return vc
    }

    case exploreViewControllerScene = "ExploreViewController"
    static func instantiateExploreViewController() -> ExploreViewController {
      guard let vc = StoryboardScene.Main.exploreViewControllerScene.viewController() as? ExploreViewController
      else {
        fatalError("ViewController 'ExploreViewController' is not of the expected class ExploreViewController.")
      }
      return vc
    }

    case featuredViewControllerScene = "FeaturedViewController"
    static func instantiateFeaturedViewController() -> FeaturedViewController {
      guard let vc = StoryboardScene.Main.featuredViewControllerScene.viewController() as? FeaturedViewController
      else {
        fatalError("ViewController 'FeaturedViewController' is not of the expected class FeaturedViewController.")
      }
      return vc
    }

    case filterViewControllerScene = "FilterViewController"
    static func instantiateFilterViewController() -> FilterViewController {
      guard let vc = StoryboardScene.Main.filterViewControllerScene.viewController() as? FilterViewController
      else {
        fatalError("ViewController 'FilterViewController' is not of the expected class FilterViewController.")
      }
      return vc
    }

    case friendsViewControllerScene = "FriendsViewController"
    static func instantiateFriendsViewController() -> FriendsViewController {
      guard let vc = StoryboardScene.Main.friendsViewControllerScene.viewController() as? FriendsViewController
      else {
        fatalError("ViewController 'FriendsViewController' is not of the expected class FriendsViewController.")
      }
      return vc
    }

    case globalActivityViewControllerScene = "GlobalActivityViewController"
    static func instantiateGlobalActivityViewController() -> GlobalActivityViewController {
      guard let vc = StoryboardScene.Main.globalActivityViewControllerScene.viewController() as? GlobalActivityViewController
      else {
        fatalError("ViewController 'GlobalActivityViewController' is not of the expected class GlobalActivityViewController.")
      }
      return vc
    }

    case inboxViewControllerScene = "InboxViewController"
    static func instantiateInboxViewController() -> InboxViewController {
      guard let vc = StoryboardScene.Main.inboxViewControllerScene.viewController() as? InboxViewController
      else {
        fatalError("ViewController 'InboxViewController' is not of the expected class InboxViewController.")
      }
      return vc
    }

    case initialNavigationViewControllerScene = "InitialNavigationViewController"
    static func instantiateInitialNavigationViewController() -> InitialNavigationViewController {
      guard let vc = StoryboardScene.Main.initialNavigationViewControllerScene.viewController() as? InitialNavigationViewController
      else {
        fatalError("ViewController 'InitialNavigationViewController' is not of the expected class InitialNavigationViewController.")
      }
      return vc
    }

    case loginViewControllerScene = "LoginViewController"
    static func instantiateLoginViewController() -> LoginViewController {
      guard let vc = StoryboardScene.Main.loginViewControllerScene.viewController() as? LoginViewController
      else {
        fatalError("ViewController 'LoginViewController' is not of the expected class LoginViewController.")
      }
      return vc
    }

    case messageViewControllerScene = "MessageViewController"
    static func instantiateMessageViewController() -> MessageViewController {
      guard let vc = StoryboardScene.Main.messageViewControllerScene.viewController() as? MessageViewController
      else {
        fatalError("ViewController 'MessageViewController' is not of the expected class MessageViewController.")
      }
      return vc
    }

    case newViewControllerScene = "NewViewController"
    static func instantiateNewViewController() -> NewViewController {
      guard let vc = StoryboardScene.Main.newViewControllerScene.viewController() as? NewViewController
      else {
        fatalError("ViewController 'NewViewController' is not of the expected class NewViewController.")
      }
      return vc
    }

    case popularViewControllerScene = "PopularViewController"
    static func instantiatePopularViewController() -> PopularViewController {
      guard let vc = StoryboardScene.Main.popularViewControllerScene.viewController() as? PopularViewController
      else {
        fatalError("ViewController 'PopularViewController' is not of the expected class PopularViewController.")
      }
      return vc
    }

    case productDetailViewControllerScene = "ProductDetailViewController"
    static func instantiateProductDetailViewController() -> ProductDetailViewController {
      guard let vc = StoryboardScene.Main.productDetailViewControllerScene.viewController() as? ProductDetailViewController
      else {
        fatalError("ViewController 'ProductDetailViewController' is not of the expected class ProductDetailViewController.")
      }
      return vc
    }

    case profileActivityViewControllerScene = "ProfileActivityViewController"
    static func instantiateProfileActivityViewController() -> ProfileActivityViewController {
      guard let vc = StoryboardScene.Main.profileActivityViewControllerScene.viewController() as? ProfileActivityViewController
      else {
        fatalError("ViewController 'ProfileActivityViewController' is not of the expected class ProfileActivityViewController.")
      }
      return vc
    }

    case profileItemViewControllerScene = "ProfileItemViewController"
    static func instantiateProfileItemViewController() -> ProfileItemViewController {
      guard let vc = StoryboardScene.Main.profileItemViewControllerScene.viewController() as? ProfileItemViewController
      else {
        fatalError("ViewController 'ProfileItemViewController' is not of the expected class ProfileItemViewController.")
      }
      return vc
    }

    case profileStoreViewControllerScene = "ProfileStoreViewController"
    static func instantiateProfileStoreViewController() -> ProfileStoreViewController {
      guard let vc = StoryboardScene.Main.profileStoreViewControllerScene.viewController() as? ProfileStoreViewController
      else {
        fatalError("ViewController 'ProfileStoreViewController' is not of the expected class ProfileStoreViewController.")
      }
      return vc
    }

    case profileViewControllerScene = "ProfileViewController"
    static func instantiateProfileViewController() -> ProfileViewController {
      guard let vc = StoryboardScene.Main.profileViewControllerScene.viewController() as? ProfileViewController
      else {
        fatalError("ViewController 'ProfileViewController' is not of the expected class ProfileViewController.")
      }
      return vc
    }

    case saleViewControllerScene = "SaleViewController"
    static func instantiateSaleViewController() -> SaleViewController {
      guard let vc = StoryboardScene.Main.saleViewControllerScene.viewController() as? SaleViewController
      else {
        fatalError("ViewController 'SaleViewController' is not of the expected class SaleViewController.")
      }
      return vc
    }

    case searchItemViewControllerScene = "SearchItemViewController"
    static func instantiateSearchItemViewController() -> SearchItemViewController {
      guard let vc = StoryboardScene.Main.searchItemViewControllerScene.viewController() as? SearchItemViewController
      else {
        fatalError("ViewController 'SearchItemViewController' is not of the expected class SearchItemViewController.")
      }
      return vc
    }

    case searchPeopleViewControllerScene = "SearchPeopleViewController"
    static func instantiateSearchPeopleViewController() -> SearchPeopleViewController {
      guard let vc = StoryboardScene.Main.searchPeopleViewControllerScene.viewController() as? SearchPeopleViewController
      else {
        fatalError("ViewController 'SearchPeopleViewController' is not of the expected class SearchPeopleViewController.")
      }
      return vc
    }

    case searchStoreViewControllerScene = "SearchStoreViewController"
    static func instantiateSearchStoreViewController() -> SearchStoreViewController {
      guard let vc = StoryboardScene.Main.searchStoreViewControllerScene.viewController() as? SearchStoreViewController
      else {
        fatalError("ViewController 'SearchStoreViewController' is not of the expected class SearchStoreViewController.")
      }
      return vc
    }

    case searchViewControllerScene = "SearchViewController"
    static func instantiateSearchViewController() -> SearchViewController {
      guard let vc = StoryboardScene.Main.searchViewControllerScene.viewController() as? SearchViewController
      else {
        fatalError("ViewController 'SearchViewController' is not of the expected class SearchViewController.")
      }
      return vc
    }

    case settingsViewControllerScene = "SettingsViewController"
    static func instantiateSettingsViewController() -> SettingsViewController {
      guard let vc = StoryboardScene.Main.settingsViewControllerScene.viewController() as? SettingsViewController
      else {
        fatalError("ViewController 'SettingsViewController' is not of the expected class SettingsViewController.")
      }
      return vc
    }

    case shopViewControllerScene = "ShopViewController"
    static func instantiateShopViewController() -> ShopViewController {
      guard let vc = StoryboardScene.Main.shopViewControllerScene.viewController() as? ShopViewController
      else {
        fatalError("ViewController 'ShopViewController' is not of the expected class ShopViewController.")
      }
      return vc
    }

    case sortViewControllerScene = "SortViewController"
    static func instantiateSortViewController() -> SortViewController {
      guard let vc = StoryboardScene.Main.sortViewControllerScene.viewController() as? SortViewController
      else {
        fatalError("ViewController 'SortViewController' is not of the expected class SortViewController.")
      }
      return vc
    }

    case storeProfileViewControllerScene = "StoreProfileViewController"
    static func instantiateStoreProfileViewController() -> StoreProfileViewController {
      guard let vc = StoryboardScene.Main.storeProfileViewControllerScene.viewController() as? StoreProfileViewController
      else {
        fatalError("ViewController 'StoreProfileViewController' is not of the expected class StoreProfileViewController.")
      }
      return vc
    }

    case tabBarControllerScene = "TabBarController"
    static func instantiateTabBarController() -> TabBarController {
      guard let vc = StoryboardScene.Main.tabBarControllerScene.viewController() as? TabBarController
      else {
        fatalError("ViewController 'TabBarController' is not of the expected class TabBarController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
