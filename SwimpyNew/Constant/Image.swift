// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum Asset: String {
  case Ic_check = "ic_check"
  case Ic_close = "ic_close"
  case Ic_flash_auto = "ic_flash_auto"
  case Ic_flash_off = "ic_flash_off"
  case Ic_flash_on = "ic_flash_on"
  case Ic_insert_photo = "ic_insert_photo"
  case Ic_loop = "ic_loop"
  case Ic_photo_camera = "ic_photo_camera"
  case Ic_radio_button_checked = "ic_radio_button_checked"
  case Ic_videocam = "ic_videocam"
  case Shutter_button = "shutter_button"
  case Video_button = "video_button"
  case Video_button_rec = "video_button_rec"
  case Ic_attach = "ic_attach"
  case Ic_back = "ic_back"
  case Ic_cancel = "ic_cancel"
  case Ic_cart = "ic_cart"
  case Ic_check_ = "ic_check_"
  case Ic_check_small = "ic_check_small"
  case Ic_check_small_0 = "ic_check_small_0"
  case Ic_dd = "ic_dd"
  case Ic_deals = "ic_deals"
  case Ic_deals_ = "ic_deals_"
  case Ic_explore = "ic_explore"
  case Ic_explore_on = "ic_explore_on"
  case Ic_facebook_Icon = "ic_facebook-icon"
  case Ic_filter = "ic_filter"
  case Ic_heart = "ic_heart"
  case Ic_heart_grey = "ic_heart_grey"
  case Ic_img = "ic_img"
  case Ic_inbox = "ic_inbox"
  case Ic_inbox_on = "ic_inbox_on"
  case Ic_like = "ic_like"
  case Ic_like_on = "ic_like_on"
  case Ic_logo = "ic_logo"
  case Ic_logo_small = "ic_logo_small"
  case Ic_menu = "ic_menu"
  case Ic_picker = "ic_picker"
  case Ic_profile = "ic_profile"
  case Ic_profile_on = "ic_profile_on"
  case Ic_search = "ic_search"
  case Ic_settings = "ic_settings"
  case Ic_share = "ic_share"
  case Ic_share_stroked = "ic_share_stroked"
  case Ic_side = "ic_side"
  case Ic_store = "ic_store"
  case Ic_store_on = "ic_store_on"
  case Ic_upload = "ic_upload"
  case Ic_uu = "ic_uu"
  case Super_G = "super g"

  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
