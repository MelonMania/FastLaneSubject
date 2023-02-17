//
//  VideoCollectionViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import RxSwift
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {

    static let identifier = "VideoCollectionViewCell"
    
    private let cellDisposeBag = DisposeBag()
    
    var disposeBag = DisposeBag()
    let onData: AnyObserver<ViewVideo>
    
    @IBOutlet weak var videoThumnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<ViewVideo>()
        
        onData = data.asObserver()

        super.init(coder: aDecoder)

        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] video in
                self?.videoTitleLabel.text = video.videoTitle
                self?.videoThumnailImageView.kf.setImage(with: URL(string: video.videoImageUrl))
            })
            .disposed(by: cellDisposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
