//
//  Utils.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit

extension UILabel {
    // 특정 텍스트 색 변경
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
