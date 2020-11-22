//
//  SimpleCard.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import UIKit

struct SimpleCardUIObject {
    var title: String?
    var description: String?
    var simpleCardType: SimpleCardType?
}

struct RainbowUIObject {
    var startValue: Int?
    var endValue: Int?
    var progressPercentage: Float?
    var progressValue: Float?
    var progressUnit: String?
}

class SimpleCard: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var gradientProgressBarComponent: GradientProgressBarComponent?
    
    
    var cardUIObject: SimpleCardUIObject? {
        didSet {
            guard let cardUIObject = cardUIObject else {return}
            titleLabel.text = cardUIObject.title
            descriptionLabel.text = cardUIObject.description
        }
    }
    
    var rainbowUIObject: RainbowUIObject? {
        didSet {
            guard let rainbowUIObject = rainbowUIObject else {
                noDataLabel.isHidden = false
                gradientProgressBarComponent?.isHidden = true
                return
            }
            guard let gradientProgressBarComponent = gradientProgressBarComponent else {return}
            gradientProgressBarComponent.simpleCardType = cardUIObject?.simpleCardType
            if (cardUIObject?.simpleCardType! == .StrideLength) {
                var value = rainbowUIObject.progressValue
                let unit = UserDefaults.standard.string(forKey: UserDefaultsKeys.measurementUnit)
                if unit == "inch" {
                    value = (value ?? 0.0) * 0.393701
                    gradientProgressBarComponent.startValue = Int(Float(rainbowUIObject.startValue ?? 0) * 0.393701)
                    gradientProgressBarComponent.endValue = Int(Float(rainbowUIObject.endValue ?? 0) * 0.393701)
                }else {
                    gradientProgressBarComponent.startValue = rainbowUIObject.startValue
                    gradientProgressBarComponent.endValue = rainbowUIObject.endValue
                }
                gradientProgressBarComponent.setProgress(progressValue: value, progressPercentage: rainbowUIObject.progressPercentage, progressUnit: unit)
            }else {
                gradientProgressBarComponent.setProgress(progressValue: rainbowUIObject.progressValue, progressPercentage: rainbowUIObject.progressPercentage, progressUnit: rainbowUIObject.progressUnit)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fillData()
    }
    
    
    func initCell() {
        gradientProgressBarComponent = GradientProgressBarComponent.initView(frame: CGRect.zero, simpleCardType: .StepRate)
        initGradientProgressBar()
        
        seperatorView.backgroundColor = UIColor(red: 206.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(named: Colors.mainTextColor)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(named: Colors.mainTextColor)
        descriptionLabel.textAlignment = .center
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        
        
        noDataLabel.font = UIFont.systemFont(ofSize: 14)
        noDataLabel.textColor = UIColor(named: Colors.mainTextColor)
        noDataLabel.text = "No data was extracted"
        noDataLabel.textAlignment = .center
        noDataLabel.isHidden = true
        
        
        mainBackground.backgroundColor = .white
        mainBackground.layer.masksToBounds = true
        mainBackground.layer.cornerRadius = 8
        
        setShadow()
        
        
    }
    
    func setShadow() {
        backgroundColor = .clear
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 6
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.black.cgColor
    }
    
    
    func initGradientProgressBar() {
        guard let gradientProgressBarComponent = gradientProgressBarComponent else {return}
        self.contentView.addSubview(gradientProgressBarComponent)
        
        gradientProgressBarComponent.translatesAutoresizingMaskIntoConstraints = false
        gradientProgressBarComponent.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        gradientProgressBarComponent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        gradientProgressBarComponent.leadingAnchor.constraint(equalTo: seperatorView.trailingAnchor).isActive = true
        gradientProgressBarComponent.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }
    
    func fillData() {
        guard let rainbowUIObject = rainbowUIObject else {
            noDataLabel.isHidden = false
            gradientProgressBarComponent?.isHidden = true
            return
        }
        guard let gradientProgressBarComponent = gradientProgressBarComponent else {return}
        gradientProgressBarComponent.simpleCardType = cardUIObject?.simpleCardType
        if (cardUIObject?.simpleCardType! == .StrideLength) {
            var value = rainbowUIObject.progressValue
            let unit = UserDefaults.standard.string(forKey: UserDefaultsKeys.measurementUnit)
            if unit == "inch" {
                value = (value ?? 0.0) * 0.393701
                gradientProgressBarComponent.startValue = Int(Float(rainbowUIObject.startValue ?? 0) * 0.393701)
                gradientProgressBarComponent.endValue = Int(Float(rainbowUIObject.endValue ?? 0) * 0.393701)
            }
            gradientProgressBarComponent.setProgress(progressValue: value, progressPercentage: rainbowUIObject.progressPercentage, progressUnit: unit)
        }else {
            gradientProgressBarComponent.setProgress(progressValue: rainbowUIObject.progressValue, progressPercentage: rainbowUIObject.progressPercentage, progressUnit: rainbowUIObject.progressUnit)
        }
    }
}
