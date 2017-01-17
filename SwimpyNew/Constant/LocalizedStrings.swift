// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Enter password
  case enterPassword
  /// Enter your full name
  case enterYourFullName
  /// Please enter valid email
  case pleaseEnterValidEmail
  /// Something went wrong
  case somethingWentWrong
  /// Your internet connection seems to be offline
  case yourInternetConnectionSeemsToBeOffline
  /// API which is hit is not present in Api Collection
  case apiWhichIsHitIsNotPresentInApiCollection
  /// Password length should be atleast 6 characters
  case passwordLengthShouldBeAtleast6Characters
  /// Product added to cart
  case productAddedToCart
  /// Edit profile
  case editProfile
  /// Terms and conditions
  case termsAndConditions
  /// Notifications
  case notifications
  /// Change Password
  case changePassword
  /// Logout
  case logout
  /// Enter Confirm Password
  case enterConfirmPassword
  /// New password should be same as confirm password
  case newPasswordShouldBeSameAsConfirmPassword
  /// Profile Edited successfully
  case profileEditedSuccessfully
  /// Success
  case success
  /// Follow store
  case followStore
  /// Following
  case following
  ///  followers
  case _Followers
  /// Order from 
  case orderFrom
  ///  following
  case _Following
  /// Follow
  case follow
  /// Others
  case others
  /// user
  case user
  /// users
  case users
  /// off
  case off
  /// on
  case on
  /// 0
  case _0
  /// 1
  case _1
  /// India
  case india
  /// BryantPro-Bold
  case bryantProBold
  /// Loading...
  case loading
  /// message
  case message
  /// data
  case data
  /// likes
  case likes
  /// statusCode
  case statusCode
  /// profilePic
  case profilePic
  /// Items
  case items
  /// Sale
  case sale
  /// People
  case people
  /// Store
  case store
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .enterPassword:
        return L10n.tr(key: "Enter password")
      case .enterYourFullName:
        return L10n.tr(key: "Enter your full name")
      case .pleaseEnterValidEmail:
        return L10n.tr(key: "Please enter valid email")
      case .somethingWentWrong:
        return L10n.tr(key: "Something went wrong")
      case .yourInternetConnectionSeemsToBeOffline:
        return L10n.tr(key: "Your internet connection seems to be offline")
      case .apiWhichIsHitIsNotPresentInApiCollection:
        return L10n.tr(key: "API which is hit is not present in Api Collection")
      case .passwordLengthShouldBeAtleast6Characters:
        return L10n.tr(key: "Password length should be atleast 6 characters")
      case .productAddedToCart:
        return L10n.tr(key: "Product added to cart")
      case .editProfile:
        return L10n.tr(key: "Edit profile")
      case .termsAndConditions:
        return L10n.tr(key: "Terms and conditions")
      case .notifications:
        return L10n.tr(key: "Notifications")
      case .changePassword:
        return L10n.tr(key: "Change Password")
      case .logout:
        return L10n.tr(key: "Logout")
      case .enterConfirmPassword:
        return L10n.tr(key: "Enter Confirm Password")
      case .newPasswordShouldBeSameAsConfirmPassword:
        return L10n.tr(key: "New password should be same as confirm password")
      case .profileEditedSuccessfully:
        return L10n.tr(key: "Profile Edited successfully")
      case .success:
        return L10n.tr(key: "Success")
      case .followStore:
        return L10n.tr(key: "Follow store")
      case .following:
        return L10n.tr(key: "Following")
      case ._Followers:
        return L10n.tr(key: " followers")
      case .orderFrom:
        return L10n.tr(key: "Order from ")
      case ._Following:
        return L10n.tr(key: " following")
      case .follow:
        return L10n.tr(key: "Follow")
      case .others:
        return L10n.tr(key: "Others")
      case .user:
        return L10n.tr(key: "user")
      case .users:
        return L10n.tr(key: "users")
      case .off:
        return L10n.tr(key: "off")
      case .on:
        return L10n.tr(key: "on")
      case ._0:
        return L10n.tr(key: "0")
      case ._1:
        return L10n.tr(key: "1")
      case .india:
        return L10n.tr(key: "India")
      case .bryantProBold:
        return L10n.tr(key: "BryantPro-Bold")
      case .loading:
        return L10n.tr(key: "Loading...")
      case .message:
        return L10n.tr(key: "message")
      case .data:
        return L10n.tr(key: "data")
      case .likes:
        return L10n.tr(key: "likes")
      case .statusCode:
        return L10n.tr(key: "statusCode")
      case .profilePic:
        return L10n.tr(key: "profilePic")
      case .items:
        return L10n.tr(key: "Items")
      case .sale:
        return L10n.tr(key: "Sale")
      case .people:
        return L10n.tr(key: "People")
      case .store:
        return L10n.tr(key: "Store")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}
