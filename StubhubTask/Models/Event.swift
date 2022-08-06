//
//  Event.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//


struct Event : Codable {

    let city : String?
    let date : String?
    let distanceFromVenue : Float?
    let id : Int?
    let name : String?
    let price : Int?
    let venueName : String?


    enum CodingKeys: String, CodingKey {
        case city = "city"
        case date = "date"
        case distanceFromVenue = "distanceFromVenue"
        case id = "id"
        case name = "name"
        case price = "price"
        case venueName = "venueName"
    }
}
