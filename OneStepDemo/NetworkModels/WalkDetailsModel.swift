//
//  WalkDetailsModel.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation

protocol WalkDetailsModelDelegate: AnyObject {
    func setWalkDetails(walkDetails: WalkDetails?)
}

class WalkDetailsModel {
    
    weak var walkDetailsDelegate: WalkDetailsModelDelegate?
    func getWalkDetails() {
        NetworkUtils.getFullParameters { (result) in
            switch result {
            case .success(let response):
                print(response)
                self.walkDetailsDelegate?.setWalkDetails(walkDetails: response)
                break
            case .failure(let error):
                print(error)
                break

            }
            
        } networkIssue: { (error) in
            print(error)
        }
    }
}
