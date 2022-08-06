//
//  Child.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

struct Child : Codable {

    let children : [Child]?
    let events : [Event]?
    let id : Int?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case children = "children"
        case events = "events"
        case id = "id"
        case name = "name"
    }
}

