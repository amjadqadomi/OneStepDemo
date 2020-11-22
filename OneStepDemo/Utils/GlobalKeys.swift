//
//  GlobalKeys.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation

struct WebService{
    static let isProduction = false
    static let devURL = "https://dev.takeonestep.com/api/v3/take_home_project/my_walks/"
    static let productionURL = "https://dev.takeonestep.com/api/v3/take_home_project/my_walks/"
    static let baseURL = isProduction ? productionURL : devURL
    
    static let stepRateOnlyURL = "c3b64b7c-caa3-444a-acda-caf9141c3b68"
    static let allParametersURL = "1c8d138e-e59b-4c31-a446-031896f6de31"
}

struct Date {
    static let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
}

struct UserDefaultsKeys {
    static let measurementUnit = "measurementUnit"
}

struct Colors {
    static let mainTextColor = "fontColor"
}
