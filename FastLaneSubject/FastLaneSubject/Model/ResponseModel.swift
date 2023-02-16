//
//  ResponseModel.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation

// MARK: - MessageListResponse
struct ResponseModel: Codable {
    var serverCode, serverMsg: String
    var results: Results
}

// MARK: - Results
struct Results: Codable {
    var displayTagList: [DisplayTagList]
    var bannerList: [BannerList]
    var recommendEventList, newEventList: [EventList]
    var ysTvList: [YsTvList]
}

// MARK: - BannerList
struct BannerList: Codable {
    var bannerID, bannerType: String
    var bannerImg: String
    var bannerLink: String
    var bannerTitle, bannerListRank, bannerStartDate, bannerEndDate: String

    enum CodingKeys: String, CodingKey {
        case bannerID = "bannerId"
        case bannerType, bannerImg, bannerLink, bannerTitle, bannerListRank, bannerStartDate, bannerEndDate
    }
}

// MARK: - DisplayTagList
struct DisplayTagList: Codable {
    var tagName: String
    var tagLink: String
    var tagRank, createAdminID, updateAdminID: Int
    var createAt, updatedAt: String
    var id: Int?
    var tagID: String?

    enum CodingKeys: String, CodingKey {
        case tagName, tagLink, tagRank
        case createAdminID = "createAdminId"
        case updateAdminID = "updateAdminId"
        case createAt, updatedAt, id
        case tagID = "tagId"
    }
}

// MARK: - EventList
struct EventList: Codable {
    var name, comment, customerName, displayName: String
    var price: Int
    var currencyName: CurrencyName
    var customerCode: String
    var score: Int
    var cpmBudgetScore: Double
    var locationName, productCode: String
    var wishCount, reviewCount, rateScore, distance: Int
    var wishIcon: WishIcon
    var thumbnailImageURL: String
    var detailLinkURL: String
    var reservationYn: ReservationYn

    enum CodingKeys: String, CodingKey {
        case name, comment, customerName, displayName, price, currencyName, customerCode, score, cpmBudgetScore, locationName, productCode, wishCount, reviewCount, rateScore, distance, wishIcon
        case thumbnailImageURL = "thumbnailImageUrl"
        case detailLinkURL = "detailLinkUrl"
        case reservationYn
    }
}

enum CurrencyName: String, Codable {
    case 원 = "원"
}

enum ReservationYn: String, Codable {
    case n = "N"
    case y = "Y"
}

enum WishIcon: String, Codable {
    case off = "off"
}

// MARK: - YsTvList
struct YsTvList: Codable {
    var tvID, tvCode, tvNameMain, tvInputDate: String
    var tvViewCount, tvMetatagTitle: String
    var tvVideoURL: String
    var tvVideoID: String
    var tvImgType: TvImgType
    var tvVideoThumb: String
    var tvFullImgURL: String

    enum CodingKeys: String, CodingKey {
        case tvID = "tvId"
        case tvCode, tvNameMain, tvInputDate, tvViewCount, tvMetatagTitle
        case tvVideoURL = "tvVideoUrl"
        case tvVideoID = "tvVideoId"
        case tvImgType, tvVideoThumb
        case tvFullImgURL = "tvFullImgUrl"
    }
}

enum TvImgType: String, Codable {
    case auto = "auto"
    case direct = "direct"
}
