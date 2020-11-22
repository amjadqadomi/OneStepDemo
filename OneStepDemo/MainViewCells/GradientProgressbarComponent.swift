//
//  GradientProgressBarComponent.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import UIKit
import GradientProgressBar

enum SimpleCardType: String {
    case StepRate = "STEP_RATE"
    case Asymmetry = "SYMMETRY_DIF"
    case StrideLength = "STRIDE_LENGTH"
    
    var bubbleColor: UIColor? {
        switch self {
        case .StepRate:
            return UIColor(named: "stepRateColor")
        case .Asymmetry:
            return UIColor(named: "asymmetryColor")
        case .StrideLength:
            return UIColor(named: "strideLengthColor")
        }
    }
    
}

class GradientProgressBarComponent: UIView {
    @IBOutlet weak var gradientProgressBar: GradientProgressBar!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var bubbleValueLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var bubbleConstraint: NSLayoutConstraint!
    
    var simpleCardType: SimpleCardType?
    var startValue: Int? = 0
    var endValue: Int? = 0
    
    var gradientColors = [UIColor(red: 241.0/255.0, green: 101.0/255.0, blue: 116.0/255.0, alpha: 1.0), UIColor(red: 247.0/255.0, green: 154.0/255.0, blue: 118.0/255.0, alpha: 1.0), UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 11.0/255.0, alpha: 1.0), UIColor(red: 75.0/255.0, green: 184.0/255.0, blue: 162.0/255.0, alpha: 1.0)]
    
    static func initView(frame: CGRect, simpleCardType: SimpleCardType, gradientColors: [UIColor]? = nil) -> GradientProgressBarComponent {
        let view: GradientProgressBarComponent = initFromNib()
        view.frame = frame
        view.simpleCardType = simpleCardType
        view.initializeUI()
        if gradientColors != nil {
            view.gradientColors = gradientColors!
        }
        return view
    }
    
    private func initializeUI() {
        bubbleImageView.tintColor = self.simpleCardType?.bubbleColor
        bubbleValueLabel.textColor = .white
        bubbleValueLabel.font = UIFont.boldSystemFont(ofSize: 22)
        bubbleValueLabel.textAlignment = .center
        bubbleValueLabel.adjustsFontSizeToFitWidth = true
        bubbleValueLabel.minimumScaleFactor = 0.5
        gradientProgressBar.gradientColors = gradientColors
        
        startLabel.font = UIFont.systemFont(ofSize: 12)
        startLabel.textColor = UIColor(named: Colors.mainTextColor)
        
        endLabel.font = UIFont.systemFont(ofSize: 12)
        endLabel.textColor = UIColor(named: Colors.mainTextColor)
        
        gradientProgressBar.clipsToBounds = true
        gradientProgressBar.layer.cornerRadius = 6
    }
    
    func setProgress(progressValue: Float?, progressPercentage: Float?, progressUnit: String?) {
        let progressValueString = String(format: "%.0f", progressValue ?? 0)
        
        let attributedString = NSMutableAttributedString(string: progressValueString + " " + (progressUnit ?? ""), attributes: [
            .font: UIFont.boldSystemFont(ofSize: 22),
          .foregroundColor: UIColor.white
        ])
        if (progressUnit != nil) {
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: progressValueString.count + 1, length: progressUnit?.count ?? 0))
        }

        
        bubbleValueLabel.attributedText = attributedString
        gradientProgressBar.setProgress(progressPercentage ?? 0.0, animated: true)
        self.layoutIfNeeded()
        bubbleConstraint.constant = (gradientProgressBar.bounds.width) * CGFloat(progressPercentage ?? 0)

        bubbleImageView.tintColor = self.simpleCardType?.bubbleColor
        startLabel.text = String(format: "%d", startValue ?? 0)
        endLabel.text = String(format: "%d", endValue ?? 0)

    }
}
