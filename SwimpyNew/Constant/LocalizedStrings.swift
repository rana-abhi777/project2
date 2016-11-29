// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Enter password
  case enterPassword
  /// Enter your fullname
  case enterYourFullname
  /// Please Enter Valid Email
  case pleaseEnterValidEmail
  /// something went wrong
  case somethingWentWrong
  /// Your internet connection seems to be offline
  case yourInternetConnectionSeemsToBeOffline
  /// API which is hit is not present in Api Collection
  case apiWhichIsHitIsNotPresentInApiCollection
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .enterPassword:
        return L10n.tr(key: "Enter password")
      case .enterYourFullname:
        return L10n.tr(key: "Enter your fullname")
      case .pleaseEnterValidEmail:
        return L10n.tr(key: "Please Enter Valid Email")
      case .somethingWentWrong:
        return L10n.tr(key: "something went wrong")
      case .yourInternetConnectionSeemsToBeOffline:
        return L10n.tr(key: "Your internet connection seems to be offline")
      case .apiWhichIsHitIsNotPresentInApiCollection:
        return L10n.tr(key: "API which is hit is not present in Api Collection")
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
