// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
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
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> SwimpyNew.InitialNavigationViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? SwimpyNew.InitialNavigationViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case activityViewControllerScene = "ActivityViewController"
    static func instantiateActivityViewController() -> SwimpyNew.ActivityViewController {
      guard let vc = StoryboardScene.Main.activityViewControllerScene.viewController() as? SwimpyNew.ActivityViewController
      else {
        fatalError("ViewController 'ActivityViewController' is not of the expected class SwimpyNew.ActivityViewController.")
      }
      return vc
    }

    case addressDetailsViewControllerScene = "AddressDetailsViewController"
    static func instantiateAddressDetailsViewController() -> SwimpyNew.AddressDetailsViewController {
      guard let vc = StoryboardScene.Main.addressDetailsViewControllerScene.viewController() as? SwimpyNew.AddressDetailsViewController
      else {
        fatalError("ViewController 'AddressDetailsViewController' is not of the expected class SwimpyNew.AddressDetailsViewController.")
      }
      return vc
    }

    case cartViewControllerScene = "CartViewController"
    static func instantiateCartViewController() -> SwimpyNew.CartViewController {
      guard let vc = StoryboardScene.Main.cartViewControllerScene.viewController() as? SwimpyNew.CartViewController
      else {
        fatalError("ViewController 'CartViewController' is not of the expected class SwimpyNew.CartViewController.")
      }
      return vc
    }

    case categoriesViewControllerScene = "CategoriesViewController"
    static func instantiateCategoriesViewController() -> SwimpyNew.CategoriesViewController {
      guard let vc = StoryboardScene.Main.categoriesViewControllerScene.viewController() as? SwimpyNew.CategoriesViewController
      else {
        fatalError("ViewController 'CategoriesViewController' is not of the expected class SwimpyNew.CategoriesViewController.")
      }
      return vc
    }

    case categoryProductsViewControllerScene = "CategoryProductsViewController"
    static func instantiateCategoryProductsViewController() -> SwimpyNew.CategoryProductsViewController {
      guard let vc = StoryboardScene.Main.categoryProductsViewControllerScene.viewController() as? SwimpyNew.CategoryProductsViewController
      else {
        fatalError("ViewController 'CategoryProductsViewController' is not of the expected class SwimpyNew.CategoryProductsViewController.")
      }
      return vc
    }

    case changePasswordViewControllerScene = "ChangePasswordViewController"
    static func instantiateChangePasswordViewController() -> SwimpyNew.ChangePasswordViewController {
      guard let vc = StoryboardScene.Main.changePasswordViewControllerScene.viewController() as? SwimpyNew.ChangePasswordViewController
      else {
        fatalError("ViewController 'ChangePasswordViewController' is not of the expected class SwimpyNew.ChangePasswordViewController.")
      }
      return vc
    }

    case countryPickerViewControllerScene = "CountryPickerViewController"
    static func instantiateCountryPickerViewController() -> SwimpyNew.CountryPickerViewController {
      guard let vc = StoryboardScene.Main.countryPickerViewControllerScene.viewController() as? SwimpyNew.CountryPickerViewController
      else {
        fatalError("ViewController 'CountryPickerViewController' is not of the expected class SwimpyNew.CountryPickerViewController.")
      }
      return vc
    }

    case dealsViewControllerScene = "DealsViewController"
    static func instantiateDealsViewController() -> SwimpyNew.DealsViewController {
      guard let vc = StoryboardScene.Main.dealsViewControllerScene.viewController() as? SwimpyNew.DealsViewController
      else {
        fatalError("ViewController 'DealsViewController' is not of the expected class SwimpyNew.DealsViewController.")
      }
      return vc
    }

    case editProfileViewControllerScene = "EditProfileViewController"
    static func instantiateEditProfileViewController() -> SwimpyNew.EditProfileViewController {
      guard let vc = StoryboardScene.Main.editProfileViewControllerScene.viewController() as? SwimpyNew.EditProfileViewController
      else {
        fatalError("ViewController 'EditProfileViewController' is not of the expected class SwimpyNew.EditProfileViewController.")
      }
      return vc
    }

    case exploreViewControllerScene = "ExploreViewController"
    static func instantiateExploreViewController() -> SwimpyNew.ExploreViewController {
      guard let vc = StoryboardScene.Main.exploreViewControllerScene.viewController() as? SwimpyNew.ExploreViewController
      else {
        fatalError("ViewController 'ExploreViewController' is not of the expected class SwimpyNew.ExploreViewController.")
      }
      return vc
    }

    case featuredViewControllerScene = "FeaturedViewController"
    static func instantiateFeaturedViewController() -> SwimpyNew.FeaturedViewController {
      guard let vc = StoryboardScene.Main.featuredViewControllerScene.viewController() as? SwimpyNew.FeaturedViewController
      else {
        fatalError("ViewController 'FeaturedViewController' is not of the expected class SwimpyNew.FeaturedViewController.")
      }
      return vc
    }

    case filterViewControllerScene = "FilterViewController"
    static func instantiateFilterViewController() -> SwimpyNew.FilterViewController {
      guard let vc = StoryboardScene.Main.filterViewControllerScene.viewController() as? SwimpyNew.FilterViewController
      else {
        fatalError("ViewController 'FilterViewController' is not of the expected class SwimpyNew.FilterViewController.")
      }
      return vc
    }

    case friendsViewControllerScene = "FriendsViewController"
    static func instantiateFriendsViewController() -> SwimpyNew.FriendsViewController {
      guard let vc = StoryboardScene.Main.friendsViewControllerScene.viewController() as? SwimpyNew.FriendsViewController
      else {
        fatalError("ViewController 'FriendsViewController' is not of the expected class SwimpyNew.FriendsViewController.")
      }
      return vc
    }

    case globalActivityViewControllerScene = "GlobalActivityViewController"
    static func instantiateGlobalActivityViewController() -> SwimpyNew.GlobalActivityViewController {
      guard let vc = StoryboardScene.Main.globalActivityViewControllerScene.viewController() as? SwimpyNew.GlobalActivityViewController
      else {
        fatalError("ViewController 'GlobalActivityViewController' is not of the expected class SwimpyNew.GlobalActivityViewController.")
      }
      return vc
    }

    case inboxViewControllerScene = "InboxViewController"
    static func instantiateInboxViewController() -> SwimpyNew.InboxViewController {
      guard let vc = StoryboardScene.Main.inboxViewControllerScene.viewController() as? SwimpyNew.InboxViewController
      else {
        fatalError("ViewController 'InboxViewController' is not of the expected class SwimpyNew.InboxViewController.")
      }
      return vc
    }

    case initialNavigationViewControllerScene = "InitialNavigationViewController"
    static func instantiateInitialNavigationViewController() -> SwimpyNew.InitialNavigationViewController {
      guard let vc = StoryboardScene.Main.initialNavigationViewControllerScene.viewController() as? SwimpyNew.InitialNavigationViewController
      else {
        fatalError("ViewController 'InitialNavigationViewController' is not of the expected class SwimpyNew.InitialNavigationViewController.")
      }
      return vc
    }

    case loginViewControllerScene = "LoginViewController"
    static func instantiateLoginViewController() -> SwimpyNew.LoginViewController {
      guard let vc = StoryboardScene.Main.loginViewControllerScene.viewController() as? SwimpyNew.LoginViewController
      else {
        fatalError("ViewController 'LoginViewController' is not of the expected class SwimpyNew.LoginViewController.")
      }
      return vc
    }

    case messageViewControllerScene = "MessageViewController"
    static func instantiateMessageViewController() -> SwimpyNew.MessageViewController {
      guard let vc = StoryboardScene.Main.messageViewControllerScene.viewController() as? SwimpyNew.MessageViewController
      else {
        fatalError("ViewController 'MessageViewController' is not of the expected class SwimpyNew.MessageViewController.")
      }
      return vc
    }

    case myOrderViewControllerScene = "MyOrderViewController"
    static func instantiateMyOrderViewController() -> SwimpyNew.MyOrderViewController {
      guard let vc = StoryboardScene.Main.myOrderViewControllerScene.viewController() as? SwimpyNew.MyOrderViewController
      else {
        fatalError("ViewController 'MyOrderViewController' is not of the expected class SwimpyNew.MyOrderViewController.")
      }
      return vc
    }

    case newViewControllerScene = "NewViewController"
    static func instantiateNewViewController() -> SwimpyNew.NewViewController {
      guard let vc = StoryboardScene.Main.newViewControllerScene.viewController() as? SwimpyNew.NewViewController
      else {
        fatalError("ViewController 'NewViewController' is not of the expected class SwimpyNew.NewViewController.")
      }
      return vc
    }

    case orderDetailViewControllerScene = "OrderDetailViewController"
    static func instantiateOrderDetailViewController() -> SwimpyNew.OrderDetailViewController {
      guard let vc = StoryboardScene.Main.orderDetailViewControllerScene.viewController() as? SwimpyNew.OrderDetailViewController
      else {
        fatalError("ViewController 'OrderDetailViewController' is not of the expected class SwimpyNew.OrderDetailViewController.")
      }
      return vc
    }

    case popularViewControllerScene = "PopularViewController"
    static func instantiatePopularViewController() -> SwimpyNew.PopularViewController {
      guard let vc = StoryboardScene.Main.popularViewControllerScene.viewController() as? SwimpyNew.PopularViewController
      else {
        fatalError("ViewController 'PopularViewController' is not of the expected class SwimpyNew.PopularViewController.")
      }
      return vc
    }

    case productDetailViewControllerScene = "ProductDetailViewController"
    static func instantiateProductDetailViewController() -> SwimpyNew.ProductDetailViewController {
      guard let vc = StoryboardScene.Main.productDetailViewControllerScene.viewController() as? SwimpyNew.ProductDetailViewController
      else {
        fatalError("ViewController 'ProductDetailViewController' is not of the expected class SwimpyNew.ProductDetailViewController.")
      }
      return vc
    }

    case profileActivityViewControllerScene = "ProfileActivityViewController"
    static func instantiateProfileActivityViewController() -> SwimpyNew.ProfileActivityViewController {
      guard let vc = StoryboardScene.Main.profileActivityViewControllerScene.viewController() as? SwimpyNew.ProfileActivityViewController
      else {
        fatalError("ViewController 'ProfileActivityViewController' is not of the expected class SwimpyNew.ProfileActivityViewController.")
      }
      return vc
    }

    case profileItemViewControllerScene = "ProfileItemViewController"
    static func instantiateProfileItemViewController() -> SwimpyNew.ProfileItemViewController {
      guard let vc = StoryboardScene.Main.profileItemViewControllerScene.viewController() as? SwimpyNew.ProfileItemViewController
      else {
        fatalError("ViewController 'ProfileItemViewController' is not of the expected class SwimpyNew.ProfileItemViewController.")
      }
      return vc
    }

    case profileStoreViewControllerScene = "ProfileStoreViewController"
    static func instantiateProfileStoreViewController() -> SwimpyNew.ProfileStoreViewController {
      guard let vc = StoryboardScene.Main.profileStoreViewControllerScene.viewController() as? SwimpyNew.ProfileStoreViewController
      else {
        fatalError("ViewController 'ProfileStoreViewController' is not of the expected class SwimpyNew.ProfileStoreViewController.")
      }
      return vc
    }

    case profileViewControllerScene = "ProfileViewController"
    static func instantiateProfileViewController() -> SwimpyNew.ProfileViewController {
      guard let vc = StoryboardScene.Main.profileViewControllerScene.viewController() as? SwimpyNew.ProfileViewController
      else {
        fatalError("ViewController 'ProfileViewController' is not of the expected class SwimpyNew.ProfileViewController.")
      }
      return vc
    }

    case refineAndSortViewControllerScene = "RefineAndSortViewController"
    static func instantiateRefineAndSortViewController() -> SwimpyNew.RefineAndSortViewController {
      guard let vc = StoryboardScene.Main.refineAndSortViewControllerScene.viewController() as? SwimpyNew.RefineAndSortViewController
      else {
        fatalError("ViewController 'RefineAndSortViewController' is not of the expected class SwimpyNew.RefineAndSortViewController.")
      }
      return vc
    }

    case refineViewControllerScene = "RefineViewController"
    static func instantiateRefineViewController() -> SwimpyNew.RefineViewController {
      guard let vc = StoryboardScene.Main.refineViewControllerScene.viewController() as? SwimpyNew.RefineViewController
      else {
        fatalError("ViewController 'RefineViewController' is not of the expected class SwimpyNew.RefineViewController.")
      }
      return vc
    }

    case saleViewControllerScene = "SaleViewController"
    static func instantiateSaleViewController() -> SwimpyNew.SaleViewController {
      guard let vc = StoryboardScene.Main.saleViewControllerScene.viewController() as? SwimpyNew.SaleViewController
      else {
        fatalError("ViewController 'SaleViewController' is not of the expected class SwimpyNew.SaleViewController.")
      }
      return vc
    }

    case searchItemViewControllerScene = "SearchItemViewController"
    static func instantiateSearchItemViewController() -> SwimpyNew.SearchItemViewController {
      guard let vc = StoryboardScene.Main.searchItemViewControllerScene.viewController() as? SwimpyNew.SearchItemViewController
      else {
        fatalError("ViewController 'SearchItemViewController' is not of the expected class SwimpyNew.SearchItemViewController.")
      }
      return vc
    }

    case searchPeopleViewControllerScene = "SearchPeopleViewController"
    static func instantiateSearchPeopleViewController() -> SwimpyNew.SearchPeopleViewController {
      guard let vc = StoryboardScene.Main.searchPeopleViewControllerScene.viewController() as? SwimpyNew.SearchPeopleViewController
      else {
        fatalError("ViewController 'SearchPeopleViewController' is not of the expected class SwimpyNew.SearchPeopleViewController.")
      }
      return vc
    }

    case searchStoreViewControllerScene = "SearchStoreViewController"
    static func instantiateSearchStoreViewController() -> SwimpyNew.SearchStoreViewController {
      guard let vc = StoryboardScene.Main.searchStoreViewControllerScene.viewController() as? SwimpyNew.SearchStoreViewController
      else {
        fatalError("ViewController 'SearchStoreViewController' is not of the expected class SwimpyNew.SearchStoreViewController.")
      }
      return vc
    }

    case searchViewControllerScene = "SearchViewController"
    static func instantiateSearchViewController() -> SwimpyNew.SearchViewController {
      guard let vc = StoryboardScene.Main.searchViewControllerScene.viewController() as? SwimpyNew.SearchViewController
      else {
        fatalError("ViewController 'SearchViewController' is not of the expected class SwimpyNew.SearchViewController.")
      }
      return vc
    }

    case settingsViewControllerScene = "SettingsViewController"
    static func instantiateSettingsViewController() -> SwimpyNew.SettingsViewController {
      guard let vc = StoryboardScene.Main.settingsViewControllerScene.viewController() as? SwimpyNew.SettingsViewController
      else {
        fatalError("ViewController 'SettingsViewController' is not of the expected class SwimpyNew.SettingsViewController.")
      }
      return vc
    }

    case shopViewControllerScene = "ShopViewController"
    static func instantiateShopViewController() -> SwimpyNew.ShopViewController {
      guard let vc = StoryboardScene.Main.shopViewControllerScene.viewController() as? SwimpyNew.ShopViewController
      else {
        fatalError("ViewController 'ShopViewController' is not of the expected class SwimpyNew.ShopViewController.")
      }
      return vc
    }

    case sortViewControllerScene = "SortViewController"
    static func instantiateSortViewController() -> SwimpyNew.SortViewController {
      guard let vc = StoryboardScene.Main.sortViewControllerScene.viewController() as? SwimpyNew.SortViewController
      else {
        fatalError("ViewController 'SortViewController' is not of the expected class SwimpyNew.SortViewController.")
      }
      return vc
    }

    case storeProfileViewControllerScene = "StoreProfileViewController"
    static func instantiateStoreProfileViewController() -> SwimpyNew.StoreProfileViewController {
      guard let vc = StoryboardScene.Main.storeProfileViewControllerScene.viewController() as? SwimpyNew.StoreProfileViewController
      else {
        fatalError("ViewController 'StoreProfileViewController' is not of the expected class SwimpyNew.StoreProfileViewController.")
      }
      return vc
    }

    case tabBarControllerScene = "TabBarController"
    static func instantiateTabBarController() -> SwimpyNew.TabBarController {
      guard let vc = StoryboardScene.Main.tabBarControllerScene.viewController() as? SwimpyNew.TabBarController
      else {
        fatalError("ViewController 'TabBarController' is not of the expected class SwimpyNew.TabBarController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
