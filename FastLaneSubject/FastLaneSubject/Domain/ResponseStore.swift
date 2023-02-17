//
//  ResponseStore.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation
import RxSwift

protocol ResponseFetchable {
    func fetchVideo() -> Observable<[YsTvList]>
    func fetchRecommendEvent() -> Observable<[EventList]>
    func fetchNewEvent() -> Observable<[EventList]>
}

class ResponseStore : ResponseFetchable {
    func fetchVideo() -> Observable<[YsTvList]> {
        return APIService.getRequest()
            .map { data in
                let videoList = data.results.ysTvList
                return videoList
            }
    }
    
    func fetchRecommendEvent() -> Observable<[EventList]> {
        return APIService.getRequest()
            .map { data in
                let recommendEventList = data.results.recommendEventList
                return recommendEventList
            }
    }
    
    func fetchNewEvent() -> Observable<[EventList]> {
        return APIService.getRequest()
            .map { data in
                let newEventList = data.results.newEventList
                return newEventList
            }
    }
}
