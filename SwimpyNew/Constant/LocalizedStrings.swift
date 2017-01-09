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
