//
//  ViewController.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import UIKit

enum MainViewSectionTypes {
    case Header
    case StepsCell
    case SimpleCard
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var walkDetails: WalkDetails?
    
    var sectionTypes: [MainViewSectionTypes] = [.Header, .StepsCell, .SimpleCard]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsTableView.register(UINib(nibName: "SimpleCard", bundle: nil), forCellReuseIdentifier: "simpleCard")
        cardsTableView.register(UINib(nibName: "WalkSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "WalkSummaryTableViewCell")
        cardsTableView.register(UINib(nibName: "WalkSummaryHeader", bundle: nil), forCellReuseIdentifier: "WalkSummaryHeader")
        cardsTableView.delegate = self
        cardsTableView.dataSource = self
        cardsTableView.removeExtraSeperatorLines()
        cardsTableView.separatorStyle = .none
        
        let walkDetailsModel = WalkDetailsModel()
        walkDetailsModel.walkDetailsDelegate = self
        walkDetailsModel.getWalkDetails()
        
        view.backgroundColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged), name: .reloadAfterUnitChange, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func unitChanged() {
        cardsTableView.reloadData()
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionTypes[section] {
        case .StepsCell:
            return 1
        case .SimpleCard:
            guard let walkDetails = self.walkDetails, let cards = walkDetails.cards else {
                return 0
            }
            return cards.count
        case .Header:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionTypes[indexPath.section] {
        case .StepsCell:
            guard let walkDetails = self.walkDetails else {
                return UITableViewCell()
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WalkSummaryTableViewCell") as? WalkSummaryTableViewCell {
                cell.selectionStyle = .none
                cell.walkSummaryUIObject = WalkSummaryUIObject(seconds: walkDetails.metadata?.seconds, steps: walkDetails.metadata?.steps)
                return cell
            }
        case .SimpleCard:
            guard let walkDetails = self.walkDetails, let cards = walkDetails.cards, cards.count > indexPath.row else {
                return UITableViewCell()
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCard") as? SimpleCard {
                cell.selectionStyle = .none
                let card = cards[indexPath.row]
                cell.cardUIObject = SimpleCardUIObject(title: card.title, description: card.description, simpleCardType: SimpleCardType(rawValue: card.gait_parameter ?? "STEP_RATE"))
                if (card.rainbow == nil) {
                    cell.rainbowUIObject = nil
                }else {
                    cell.rainbowUIObject = RainbowUIObject(startValue: card.rainbow?.start, endValue: card.rainbow?.end, progressPercentage: card.rainbow?.bubble_percent, progressValue: card.rainbow?.value, progressUnit: card.rainbow?.units)
                }
                return cell
            }
        case .Header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WalkSummaryHeader") as? WalkSummaryHeader {
                cell.selectionStyle = .none
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sectionTypes[indexPath.section] {
        case .StepsCell:
            return 80
        case .SimpleCard:
            return 160
        case .Header:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
}

extension MainViewController: WalkDetailsModelDelegate {
    func setWalkDetails(walkDetails: WalkDetails?) {
        self.walkDetails = walkDetails
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.cardsTableView.reloadData()
    }
}
