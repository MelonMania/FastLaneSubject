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
                guard let videoList = data.results.ysTvList else { return }
                return videoList
            }
    }
    
    func fetchRecommendEvent() -> Observable<[EventList]> {
        return APIService.getRequest()
            .map { data in
                guard let recommendEventList = data.results.recommendEventList else { return }
                return recommendEventList
            }
    }
    
    func fetchNewEvent() -> Observable<[EventList]> {
        return APIService.getRequest()
            .map { data in
                guard let newEventList = data.results.newEventList else { return }
                return newEventList
            }
    }
}
