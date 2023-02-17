//
//  ViewVideo.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/17.
//

import Foundation

struct ViewVideo {
    var videoImageUrl : String
    var videoTitle : String
    var videoUrl : String
    
    init(_ video: YsTvList) {
        videoImageUrl = video.tvFullImgURL
        videoTitle = video.tvNameMain
        videoUrl = video.tvVideoURL
    }

    init(videoImageUrl: String, videoTitle: String, videoUrl: String) {
        self.videoImageUrl = videoImageUrl
        self.videoTitle = videoTitle
        self.videoUrl = videoUrl
    }
}
