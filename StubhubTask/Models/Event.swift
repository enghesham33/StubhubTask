//
//  Event.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Combine


class Event : Codable, ObservableObject, Identifiable {

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
    
    init(city : String?,
        date : String?,
        distanceFromVenue : Float?,
        id : Int?,
        name : String?,
        price : Int?,
         venueName : String?) {
        self.city = city
        self.date = date
        self.distanceFromVenue = distanceFromVenue
        self.id = id
        self.name = name
        self.price = price
        self.venueName = venueName
    }
}
