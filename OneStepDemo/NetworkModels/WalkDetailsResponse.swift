//
//  WalkDetailsResponse.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation

struct WalkDetails: Codable {
    var cards: [Card]?
    var insight: Insight?
    var metadata: Metadata?
    var version: Int?
}


struct Card: Codable {
    var description: String?
    var gait_parameter: String?
    var rainbow: Rainbow?
    var template: String?
    var title: String?
    var version: Int?
}

struct Insight: Codable {
    var content: String?
    var template: String?
    var title: String?
    var version: Int?
}

struct Metadata: Codable {
    var extraction_level: Int?
    var seconds: Int?
    var steps: Int?
    var timestamp: String?
    var title: String?
    var uuid: String?
}

struct Rainbow: Codable {
    var asset_id: String?
    var bubble_color: String?
    var bubble_percent: Float?
    var end: Int?
    var start: Int?
    var template: String?
    var units: String?
    var value: Float?
    var version: Int?
}
