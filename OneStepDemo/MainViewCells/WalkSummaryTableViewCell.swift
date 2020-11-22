//
//  WalkSummaryTableViewCell.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import UIKit

struct WalkSummaryUIObject {
    var seconds: Int?
    var steps: Int?
}


class WalkSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    var walkSummaryUIObject: WalkSummaryUIObject? {
        didSet {
            guard let walkSummaryUIObject = walkSummaryUIObject else {return}
            let stepsString = String(format: "%d", walkSummaryUIObject.steps ?? 0)
            let secondsString = String(format: "%d", walkSummaryUIObject.seconds ?? 0)
            let stepsUnit = "Steps"
            let secondsUnit = "sec"
            
            let stepsAttributedString = NSMutableAttributedString(string: stepsString + " " + stepsUnit , attributes: [
                .font: UIFont.boldSystemFont(ofSize: 30),
              .foregroundColor: UIColor.black
            ])
            stepsAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: stepsString.count + 1, length: stepsUnit.count))
            
            
            
            let secondsAttributedString = NSMutableAttributedString(string: secondsString + " " + secondsUnit , attributes: [
                .font: UIFont.boldSystemFont(ofSize: 30),
              .foregroundColor: UIColor.black
            ])
            secondsAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: secondsString.count + 1, length: secondsUnit.count))


            timeLabel.attributedText = secondsAttributedString
            stepsLabel.attributedText = stepsAttributedString
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }
    
    func initCell() {
        backgroundColor = .clear
        timeLabel.textAlignment = .center
        stepsLabel.textAlignment = .center
        seperatorView.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 216.0/255.0)
    }
}
