//
//  EventTableViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import RxSwift
import Kingfisher

class EventTableViewCell: UITableViewCell {

    static let identifier = "EventTableViewCell"
    
    private let cellDisposeBag = DisposeBag()
    
    var disposeBag = DisposeBag()
    let onData: AnyObserver<ViewEvent>
    
    @IBOutlet weak var thumnailImageView: UIImageView! // 썸네일 이미지
    
    @IBOutlet weak var displayNameLabel: UILabel! // 병원 이름
    @IBOutlet weak var nameLabel: UILabel! // 이벤트 이름
    @IBOutlet weak var commentLabel: UILabel! // 설명
    @IBOutlet weak var priceLabel: UILabel! // 가격
    
    @IBOutlet weak var wishCountLabel: UILabel! // 관심도 수
    @IBOutlet weak var reviewCountLabel: UILabel! // 리뷰수
    @IBOutlet weak var rateLabel: UILabel! // 평점
    
    required init?(coder aDecoder: NSCoder) {
        let data = PublishSubject<ViewEvent>()
        
        onData = data.asObserver()

        super.init(coder: aDecoder)

        data.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] event in
                self?.thumnailImageView.kf.setImage(with: URL(string: event.eventImageURL), placeholder: UIImage(named: "DefaultEventImage"))
                
                self?.displayNameLabel.text = event.displayName
                self?.nameLabel.text = event.eventName
                self?.commentLabel.text = event.comment
                self?.priceLabel.text = "\(Double(event.price) / Double(10000))"
                
                self?.wishCountLabel.text = "관심도\(event.wishCount)+"
                self?.reviewCountLabel.text = "리뷰\(event.reviewCount)+"
                self?.rateLabel.text = "★\(event.rate)"
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
