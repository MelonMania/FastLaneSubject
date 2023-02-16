//
//  VideoCollectionViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {

    static let identifier = "VideoCollectionViewCell"
    
    @IBOutlet weak var videoThumnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
