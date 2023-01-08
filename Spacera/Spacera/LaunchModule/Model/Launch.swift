//
//  Launch.swift
//  Spacera
//
//  Created by Artem Bilyi on 08.01.2023.
//

import Foundation
// MARK: - LaunchesModel
struct Launch: Decodable {
    let rocket: String?
    let name: String?
    let success: Bool?
    let dateLocal: String?
    let net: Bool?
    let window: Int?
    let id: String?
}
