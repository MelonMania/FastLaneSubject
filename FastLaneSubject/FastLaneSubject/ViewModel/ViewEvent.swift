//
//  ViewEvent.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation

struct ViewEvent {
    var eventImageURL : String
    var displayName : String
    var eventName : String
    var comment : String
    var price : Int
    
    var wishCount : Int
    var reviewCount : Int
    var rate : Double
    
    init(_ event: EventList) {
        eventImageURL = event.thumbnailImageURL
        displayName = event.displayName
        eventName = event.name
        comment = event.comment
        price = event.price
        
        wishCount = event.wishCount
        reviewCount = event.reviewCount
        rate = Double(event.rateScore / event.reviewCount)
    }
    
    init(eventImageURL: String, displayName: String, eventName: String, comment : String, price : Int, wishCount : Int, reviewCount : Int, rate : Double) {
        self.eventImageURL = eventImageURL
        self.displayName = displayName
        self.eventName = eventName
        self.comment = comment
        self.price = price
        self.wishCount = wishCount
        self.reviewCount = reviewCount
        self.rate = rate
    }
}
