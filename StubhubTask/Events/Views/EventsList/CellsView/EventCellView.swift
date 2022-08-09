//
//  EventCellView.swift
//  StubhubTask
//
//  Created by Hesham Donia on 09/08/2022.
//

import SwiftUI

struct EventCellView: View {
    
    @ObservedObject var event: Event
    
    var body: some View {
        VStack {
            Text(event.name ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame( height: 8)
            Text(event.city ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame (height: 8)
            Text("\(event.price ?? 0)$")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct EventCellView_Previews: PreviewProvider {
    static var previews: some View {
        EventCellView(event: Event(city: "Ismailia", date: "20/12/2020", distanceFromVenue: nil, id: 1, name: "7ammo beka", price: 120, venueName: "Venue name"))
    }
}
