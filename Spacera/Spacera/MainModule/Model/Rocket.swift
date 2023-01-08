//
//  Rocket.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation
// MARK: - RocketModel
struct Rocket: Decodable {
    let height, diameter: Diameter?
    let mass: Mass?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let payloadWeights: [PayloadWeight]?
    let flickrImages: [String]?
    let name: String?
    let costPerLaunch: Int?
    let firstFlight, country: String?
    let id: String?
}

extension Rocket {
    // MARK: - Diameter
    struct Diameter: Decodable {
        let meters, feet: Double?
    }
}

extension Rocket {
    // MARK: - FirstStage
    struct FirstStage: Decodable {
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
    }
}

extension Rocket {
    // MARK: - Mass
    struct Mass: Decodable {
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - PayloadWeight
    struct PayloadWeight: Decodable {
        let id, name: String?
        let kg, lb: Int?
    }
}

extension Rocket {
    // MARK: - SecondStage
    struct SecondStage: Decodable {
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
    }
}

