//
//  Keys.swift
//  Panache
//
//  Created by Aseem 10 on 9/28/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import Foundation

enum Keys : String {
    
    //MARK:- methods to call api
    case Post = "POST"
    case Delete = "DELETE"
    case Put = "PUT"
    case Get = "GET"
    
    //MARK:- parameters name
    
    case UserType = "user_type"
    case Password = "password"
    case Address = "address"
    case MobileNumber = "mobile_number"
    case CompanyName = "company_name"
    case PostalCode = "postal_code"
    case Employees = "employees"
    case Website = "website"
    case Role = "role"
    case FacebookId = "facebook_id"
    case FacebookAccessToken = "facebook_access_token"
    case ApiToken = "api_token"
    case Code = "code"
    case Image = "image"
    
    case Video = "video"
    case Title = "title"
    case Link = "link"
    case Hashtag = "hashtag"
    case StartDate = "start_date"
    case TargetInfluencer = "target_influencer"
    case MessageInfluencer = "message_influencer"
    case Budget = "budget"
    case UserCount = "user_count"
    case GroupId = "group_id"
    
    case imageUrl = "imageUrl"
    
    case isBlocked = "isBlocked"
    case Data = "data"
    case dataSend = "dataSend"
    case ID = "_id"
    case CreatorID = "createrID"
    case Description = "description"
    case Order = "order"
    case Timestamp = "timestamp"
    case IsDeleted = "is_deleted"
    case Name = "name"
    case CategoryImage = "categoryImage"
    case Thumbnail = "thumbnail"
    case Original = "original"
    case CategoryId = "categoryId"
    case CreaterType = "createrType"
    case SubCategoryImage = "subCategoryImage"
    case ProfilePicURL = "profilePicURL"
    case Email = "email"
    case PageNo = "pageNo"
    case AccessToken = "accessToken"
    case TotalFollowing = "totalFollowing"
    case TotalFollowedBy = "totalFollowedBy"
    case FollowStatus = "followStatus"
    case follow = "+FOLLOW"
    case followed = "FOLLOWED"
    case CountryName = "countryName"
    case DeviceToken = "deviceToken"
    case MoreFormStore = "moreFormStore"
    case LikedUser = "likedUser"
    case IsDelete = "is_delete"
    case LikeBy = "likeBy"
    case SubCategoryDetails = "subCategoryDetails"
    case Color = "color"
    case Size = "size"
    case BasePriceUnit = "base_price_unit"
    case TotalLikes = "totalLikes"
    case ProductName = "productName"
    case SubcategoryId = "subcategoryId"
    case FlatValue = "flatValue"
    case Percentage = "percentage"
    case CouponCode = "couponCode"
    case CountryCode = "countryCode"
    case Returns = "returns"
    case applyCoupon = "applyCoupon"
    case TotalPrice = "total_price"
    case RepostPrice = "repost_price"
    case Location = "location"
    case Notification = "notification"
    case ShippingPrice = "shippingPrice"
    case IsActive = "isActive"
    case DefaultImage = "defaultImage"
    case LikesStatus = "likesStatus"
    case Share = "share"
    case RelatedProducts = "relatedProducts"
    case CoverPicURL = "coverPicURL"
    case TotalFollow = "totalFollow"
    case StoreName = "storeName"
    case Featured = "featured"
    case Variations = "variations"
    case Sku = "sku"
    case OtherImage = "otherImage"
    case FlatDiscount = "flatDiscount"
    case SellerData = "sellerData"
    case isFeatured = "isFeatured"
    case FirstTimeLogin = "firstTimeLogin"
    case emailVerified = "emailVerified"
    
    case DataToSend = "dataToSend"
    case ProductDetails = "productDetails"
    case Quantity = "quantity"
    
    case CartData = "cartData"
    case ActiveData = "activeData"
    case UserId = "userId"
    case IdType = "idType"
    
    case Value = "value"
    case Text = "text"
    case Item = "item"
    case Store = "store"
    case User = "user"
    case Time = "time"
    case Pic = "pic"
    case IsDefault = "isDefault"
    case PhoneNo = "phoneNo"
    case Zipcode = "zipcode"
    case State = "state"
    case City = "city"
    case AddressLine1 = "addressLine1"
    case AddressLine2 = "addressLine2"
    case FullName = "fullName"
    case Date = "date"
    
    case cartLength = "cartLength"
    case productId = "productId"
    case thumbnailImage = "thumbnailImage"
    case originalImage = "originalImage"
    case price = "price"
    case sellerId = "sellerId"
    case supllierId = "supllierId"
    case shippingCost = "shippingCost"
  
    case parentSupplierId = "parentSupplierId"
    case createrId = "createrId"
    case nationalShipCost = "nationalShipCost"
    case internationalShipCost = "internationalShipCost"
    
    
    // switch values 
    case CUSTOMER = "CUSTOMER"
    case PRODUCT = "PRODUCT"
    case SELLER = "SELLER"
    
    case DialCode = "dial_code"
    case status = "status"
    case deliveryNotAvailable = "deliveryNotAvailable"
    case deliveryAvailable = "deliveryAvailable"
    
    
    case message = "message"
    case receiverId = "receiverId"
    case createdAt = "createdAt"
    
    case reply = "Write a reply.."
    case writeMessage = "Write the message"
    
    case stores = "STORES"
    case popular = "POPULAR"
    case sales = "SALE"
    case categories = "CATEGORIES"
    case deals = "Deals"
    case featured = "Featured"
}

enum StringNames:String{
    case awsome = "AWSM!"
    case like = "LIKE"
    case one = "1"
    case empty = ""
    case from = "from"
    case to = "to"
    case blocked = "Sorry..You are blocked by the Admin.."
}
