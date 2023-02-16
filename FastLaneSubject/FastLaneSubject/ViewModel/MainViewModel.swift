//
//  MainViewModel.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation
import RxSwift

protocol MainViewModelType {
    var fetchVideo : AnyObserver<Void> { get }
    var fetchRecommendEvent : AnyObserver<Void> { get }
    var fetchNewEvent : AnyObserver<Void> { get }
    
    var errorMessage: Observable<NSError> { get }
    var allVideos : Observable<[ViewVideo]> { get }
    var allRecommendEvents : Observable<[ViewEvent]> { get }
    var allNewEvents : Observable<[ViewEvent]> { get }
}

class MainViewModel : MainViewModelType {
    let disposeBag = DisposeBag()
    
    // input
    let fetchVideo: AnyObserver<Void>
    let fetchRecommendEvent: AnyObserver<Void>
    let fetchNewEvent: AnyObserver<Void>
    
    // output
    let errorMessage: Observable<NSError>
    let allVideos: Observable<[ViewVideo]>
    let allRecommendEvents: Observable<[ViewEvent]>
    let allNewEvents: Observable<[ViewEvent]>
    
    init(domain : ResponseFetchable = ResponseStore()) {
        let videofetching = PublishSubject<Void>()
        let recommendEventsfetching = PublishSubject<Void>()
        let newEventsfetching = PublishSubject<Void>()
        
        let videos = BehaviorSubject<[ViewVideo]>(value: [])
        let recommendEvents = BehaviorSubject<[ViewEvent]>(value: [])
        let newEvents = BehaviorSubject<[ViewEvent]>(value: [])
        
        let activating = BehaviorSubject<Bool>(value: false)
        let error = PublishSubject<Error>()
        
        // input
        fetchVideo = videofetching.asObserver()
        videofetching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap(domain.fetchVideo)
            .map { $0.map { ViewVideo($0) } }
            .do(onNext: { _ in activating.onNext(false) })
            .do(onError: { err in error.onNext(err) })
            .subscribe(onNext: videos.onNext)
            .disposed(by: disposeBag)
        
        fetchRecommendEvent = recommendEventsfetching.asObserver()
        recommendEventsfetching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap(domain.fetchRecommendEvent)
            .map { $0.map { ViewEvent($0) } }
            .do(onNext: { _ in activating.onNext(false) })
            .do(onError: { err in error.onNext(err) })
            .subscribe(onNext: recommendEvents.onNext)
            .disposed(by: disposeBag)
        
        fetchNewEvent = newEventsfetching.asObserver()
        newEventsfetching
            .do(onNext: { _ in activating.onNext(true) })
            .flatMap(domain.fetchNewEvent)
            .map { $0.map { ViewEvent($0) } }
            .do(onNext: { _ in activating.onNext(false) })
            .do(onError: { err in error.onNext(err) })
            .subscribe(onNext: newEvents.onNext)
            .disposed(by: disposeBag)
                            
        // output
        allVideos = videos
        allRecommendEvents = recommendEvents
        allNewEvents = newEvents
                
        errorMessage = error.map { $0 as NSError }
    }
}
