//
//  Password.swift
//  PasswordKeeper
//
//  Created by Jegor on 11.04.2023.
//

import Foundation

struct PasswordItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let login: String
    let password: String
}
