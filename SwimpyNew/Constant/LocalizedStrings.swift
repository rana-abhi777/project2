// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  ///  followers
  case _Followers
  ///  following
  case _Following
  /// $1-20
  case _120
  /// $101-200
  case _101200
  /// $201-500
  case _201500
  /// $21-100
  case _21100
  /// $501+
  case _501
  /// 0
  case _0
  /// 1
  case _1
  /// Address added successfully
  case addressAddedSuccessfully
  /// Address edited successfully
  case addressEditedSuccessfully
  /// Any Price
  case anyPrice
  /// API which is hit is not present in Api Collection
  case apiWhichIsHitIsNotPresentInApiCollection
  /// Are you sure?
  case areYouSure
  /// Black
  case black
  /// Blue
  case blue
  /// Brown
  case brown
  /// BryantPro-Bold
  case bryantProBold
  /// Cancel
  case cancel
  /// Change Password
  case changePassword
  /// Color
  case color
  /// data
  case data
  /// Edit profile
  case editProfile
  /// Enter address line 1
  case enterAddressLine1
  /// Enter address line 2
  case enterAddressLine2
  /// Enter city
  case enterCity
  /// Enter Confirm Password
  case enterConfirmPassword
  /// Enter country
  case enterCountry
  /// Enter email
  case enterEmail
  /// Enter mobile number
  case enterMobileNumber
  /// Enter old password
  case enterOldPassword
  /// Enter password
  case enterPassword
  /// Enter state
  case enterState
  /// Enter your full name
  case enterYourFullName
  /// Enter your valid name
  case enterYourValidName
  /// Enter zipcode
  case enterZipcode
  /// Follow
  case follow
  /// Follow store
  case followStore
  /// Following
  case following
  /// Gold
  case gold
  /// Gray
  case gray
  /// Green
  case green
  /// India
  case india
  /// Items
  case items
  /// likes
  case likes
  /// Logout
  case logout
  /// Maximum quantity reached
  case maximumQuantityReached
  /// message
  case message
  /// Minimum quantity is one
  case minimumQuantityIsOne
  /// My Orders
  case myOrders
  /// New password should be same as confirm password
  case newPasswordShouldBeSameAsConfirmPassword
  /// Newest
  case newest
  /// Notifications
  case notifications
  /// off
  case off
  /// OK
  case ok
  /// on
  case on
  /// Orange
  case orange
  /// Order from 
  case orderFrom
  /// Order placed successfully
  case orderPlacedSuccessfully
  /// Others
  case others
  /// Password length should be atleast 6 characters
  case passwordLengthShouldBeAtleast6Characters
  /// Password updated successfully
  case passwordUpdatedSuccessfully
  /// People
  case people
  /// Pink
  case pink
  /// Placed on 
  case placedOn
  /// Please enter valid email
  case pleaseEnterValidEmail
  /// Please select country
  case pleaseSelectCountry
  /// Popular
  case popular
  /// Price
  case price
  /// Price : High to Low
  case priceHighToLow
  /// Price : Low to High
  case priceLowToHigh
  /// Product added to cart
  case productAddedToCart
  /// Product is out of stock
  case productIsOutOfStock
  /// Profile Edited successfully
  case profileEditedSuccessfully
  /// profilePic
  case profilePic
  /// Purple
  case purple
  /// Red
  case red
  /// Sale
  case sale
  /// Select Country
  case selectCountry
  /// Silver
  case silver
  /// Skyblue
  case skyblue
  /// Something went wrong
  case somethingWentWrong
  /// statusCode
  case statusCode
  /// Store
  case store
  /// Sub Category
  case subCategory
  /// Success
  case success
  /// Terms and conditions
  case termsAndConditions
  /// user
  case user
  /// users
  case users
  /// White
  case white
  /// Yellow
  case yellow
  /// Your internet connection seems to be offline
  case yourInternetConnectionSeemsToBeOffline
  /// Loading...
  case loading
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case ._Followers:
        return L10n.tr(key: " followers")
      case ._Following:
        return L10n.tr(key: " following")
      case ._120:
        return L10n.tr(key: "$1-20")
      case ._101200:
        return L10n.tr(key: "$101-200")
      case ._201500:
        return L10n.tr(key: "$201-500")
      case ._21100:
        return L10n.tr(key: "$21-100")
      case ._501:
        return L10n.tr(key: "$501+")
      case ._0:
        return L10n.tr(key: "0")
      case ._1:
        return L10n.tr(key: "1")
      case .addressAddedSuccessfully:
        return L10n.tr(key: "Address added successfully")
      case .addressEditedSuccessfully:
        return L10n.tr(key: "Address edited successfully")
      case .anyPrice:
        return L10n.tr(key: "Any Price")
      case .apiWhichIsHitIsNotPresentInApiCollection:
        return L10n.tr(key: "API which is hit is not present in Api Collection")
      case .areYouSure:
        return L10n.tr(key: "Are you sure?")
      case .black:
        return L10n.tr(key: "Black")
      case .blue:
        return L10n.tr(key: "Blue")
      case .brown:
        return L10n.tr(key: "Brown")
      case .bryantProBold:
        return L10n.tr(key: "BryantPro-Bold")
      case .cancel:
        return L10n.tr(key: "Cancel")
      case .changePassword:
        return L10n.tr(key: "Change Password")
      case .color:
        return L10n.tr(key: "Color")
      case .data:
        return L10n.tr(key: "data")
      case .editProfile:
        return L10n.tr(key: "Edit profile")
      case .enterAddressLine1:
        return L10n.tr(key: "Enter address line 1")
      case .enterAddressLine2:
        return L10n.tr(key: "Enter address line 2")
      case .enterCity:
        return L10n.tr(key: "Enter city")
      case .enterConfirmPassword:
        return L10n.tr(key: "Enter Confirm Password")
      case .enterCountry:
        return L10n.tr(key: "Enter country")
      case .enterEmail:
        return L10n.tr(key: "Enter email")
      case .enterMobileNumber:
        return L10n.tr(key: "Enter mobile number")
      case .enterOldPassword:
        return L10n.tr(key: "Enter old password")
      case .enterPassword:
        return L10n.tr(key: "Enter password")
      case .enterState:
        return L10n.tr(key: "Enter state")
      case .enterYourFullName:
        return L10n.tr(key: "Enter your full name")
      case .enterYourValidName:
        return L10n.tr(key: "Enter your valid name")
      case .enterZipcode:
        return L10n.tr(key: "Enter zipcode")
      case .follow:
        return L10n.tr(key: "Follow")
      case .followStore:
        return L10n.tr(key: "Follow store")
      case .following:
        return L10n.tr(key: "Following")
      case .gold:
        return L10n.tr(key: "Gold")
      case .gray:
        return L10n.tr(key: "Gray")
      case .green:
        return L10n.tr(key: "Green")
      case .india:
        return L10n.tr(key: "India")
      case .items:
        return L10n.tr(key: "Items")
      case .likes:
        return L10n.tr(key: "likes")
      case .logout:
        return L10n.tr(key: "Logout")
      case .maximumQuantityReached:
        return L10n.tr(key: "Maximum quantity reached")
      case .message:
        return L10n.tr(key: "message")
      case .minimumQuantityIsOne:
        return L10n.tr(key: "Minimum quantity is one")
      case .myOrders:
        return L10n.tr(key: "My Orders")
      case .newPasswordShouldBeSameAsConfirmPassword:
        return L10n.tr(key: "New password should be same as confirm password")
      case .newest:
        return L10n.tr(key: "Newest")
      case .notifications:
        return L10n.tr(key: "Notifications")
      case .off:
        return L10n.tr(key: "off")
      case .ok:
        return L10n.tr(key: "OK")
      case .on:
        return L10n.tr(key: "on")
      case .orange:
        return L10n.tr(key: "Orange")
      case .orderFrom:
        return L10n.tr(key: "Order from ")
      case .orderPlacedSuccessfully:
        return L10n.tr(key: "Order placed successfully")
      case .others:
        return L10n.tr(key: "Others")
      case .passwordLengthShouldBeAtleast6Characters:
        return L10n.tr(key: "Password length should be atleast 6 characters")
      case .passwordUpdatedSuccessfully:
        return L10n.tr(key: "Password updated successfully")
      case .people:
        return L10n.tr(key: "People")
      case .pink:
        return L10n.tr(key: "Pink")
      case .placedOn:
        return L10n.tr(key: "Placed on ")
      case .pleaseEnterValidEmail:
        return L10n.tr(key: "Please enter valid email")
      case .pleaseSelectCountry:
        return L10n.tr(key: "Please select country")
      case .popular:
        return L10n.tr(key: "Popular")
      case .price:
        return L10n.tr(key: "Price")
      case .priceHighToLow:
        return L10n.tr(key: "Price : High to Low")
      case .priceLowToHigh:
        return L10n.tr(key: "Price : Low to High")
      case .productAddedToCart:
        return L10n.tr(key: "Product added to cart")
      case .productIsOutOfStock:
        return L10n.tr(key: "Product is out of stock")
      case .profileEditedSuccessfully:
        return L10n.tr(key: "Profile Edited successfully")
      case .profilePic:
        return L10n.tr(key: "profilePic")
      case .purple:
        return L10n.tr(key: "Purple")
      case .red:
        return L10n.tr(key: "Red")
      case .sale:
        return L10n.tr(key: "Sale")
      case .selectCountry:
        return L10n.tr(key: "Select Country")
      case .silver:
        return L10n.tr(key: "Silver")
      case .skyblue:
        return L10n.tr(key: "Skyblue")
      case .somethingWentWrong:
        return L10n.tr(key: "Something went wrong")
      case .statusCode:
        return L10n.tr(key: "statusCode")
      case .store:
        return L10n.tr(key: "Store")
      case .subCategory:
        return L10n.tr(key: "Sub Category")
      case .success:
        return L10n.tr(key: "Success")
      case .termsAndConditions:
        return L10n.tr(key: "Terms and conditions")
      case .user:
        return L10n.tr(key: "user")
      case .users:
        return L10n.tr(key: "users")
      case .white:
        return L10n.tr(key: "White")
      case .yellow:
        return L10n.tr(key: "Yellow")
      case .yourInternetConnectionSeemsToBeOffline:
        return L10n.tr(key: "Your internet connection seems to be offline")
      case .loading:
        return L10n.tr(key: "Loading...")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}
