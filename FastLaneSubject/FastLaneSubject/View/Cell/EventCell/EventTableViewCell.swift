//
//  EventTableViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    static let identifier = "EventTableViewCell"
    
    @IBOutlet weak var thumnailImageView: UIImageView! // 썸네일 이미지
    
    @IBOutlet weak var displayNameLabel: UILabel! // 병원 이름
    @IBOutlet weak var nameLabel: UILabel! // 이벤트 이름
    @IBOutlet weak var commentLabel: UILabel! // 설명
    @IBOutlet weak var priceLabel: UILabel! // 가격
    
    @IBOutlet weak var wishCountLabel: UILabel! // 관심도 수
    @IBOutlet weak var reviewCountLabel: UILabel! // 리뷰수
    @IBOutlet weak var rateLabel: UILabel! // 평점
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
