//
//  EventCellView.swift
//  StubhubTask
//
//  Created by Hesham Donia on 09/08/2022.
//

import SwiftUI

struct EventCellView: View {
    
    var event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(event.name ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(event.city ?? "")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(event.price ?? 0)$")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        })
    }
}

struct EventCellView_Previews: PreviewProvider {
    static var previews: some View {
        EventCellView(event: Event(city: "Ismailia", date: "20/12/2020", distanceFromVenue: nil, id: 1, name: "7ammo beka", price: 120, venueName: "Venue name"))
    }
}
