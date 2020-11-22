//
//  WalkSummaryHeader.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import UIKit

class WalkSummaryHeader: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }
    
    func initCell() {
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.text = "Walk Summary"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.string(forKey: UserDefaultsKeys.measurementUnit) == "cm" ? 0 : 1
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for:.valueChanged)
    }
    
    @objc func segmentedControlValueChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("cm", forKey: UserDefaultsKeys.measurementUnit)
        }else {
            UserDefaults.standard.setValue("inch", forKey: UserDefaultsKeys.measurementUnit)
        }
        NotificationCenter.default.post(name: .reloadAfterUnitChange, object: nil)
    }
}
