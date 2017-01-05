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
  case icCheck = "ic_check"
  case icClose = "ic_close"
  case icFlashAuto = "ic_flash_auto"
  case icFlashOff = "ic_flash_off"
  case icFlashOn = "ic_flash_on"
  case icInsertPhoto = "ic_insert_photo"
  case icLoop = "ic_loop"
  case icPhotoCamera = "ic_photo_camera"
  case icRadioButtonChecked = "ic_radio_button_checked"
  case icVideocam = "ic_videocam"
  case shutterButton = "shutter_button"
  case videoButton = "video_button"
  case videoButtonRec = "video_button_rec"
  case icAttach = "ic_attach"
  case icBack = "ic_back"
  case icCancel = "ic_cancel"
  case icCart = "ic_cart"
  case icCheckSmall = "ic_check_small"
  case icCheckSmall0 = "ic_check_small_0"
  case icDd = "ic_dd"
  case icDeals = "ic_deals"
  case icDealsGrey = "ic_deals_grey"
  case icExplore = "ic_explore"
  case icExploreOn = "ic_explore_on"
  case icFacebookIcon = "ic_facebook-icon"
  case icFilter = "ic_filter"
  case icHeart = "ic_heart"
  case icHeartGrey = "ic_heart_grey"
  case icImg = "ic_img"
  case icInbox = "ic_inbox"
  case icInboxOn = "ic_inbox_on"
  case icLike = "ic_like"
  case icLikeOn = "ic_like_on"
  case icLogo = "ic_logo"
  case icLogoSmall = "ic_logo_small"
  case icMenu = "ic_menu"
  case icPicker = "ic_picker"
  case icProfile = "ic_profile"
  case icProfileOn = "ic_profile_on"
  case icSearch = "ic_search"
  case icSettings = "ic_settings"
  case icShare = "ic_share"
  case icShareStroked = "ic_share_stroked"
  case icSide = "ic_side"
  case icStore = "ic_store"
  case icStoreOn = "ic_store_on"
  case icToggleOff = "ic_toggle_off"
  case icToggleOn = "ic_toggle_on"
  case icUpload = "ic_upload"
  case icUu = "ic_uu"
  case superG = "super g"

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
