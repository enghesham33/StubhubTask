//
//  EventsViewModel.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

class EventsViewModel: BaseViewModel, ObservableObject {
    
    @Published private(set) var events: [Event] = []
    @Published private(set) var filteredEvents: [Event] = []
    
    init(repository: EventsRepository) {
        self.repository = repository
    }
    
    private let repository: EventsRepository
    var filterOperation = FilterOperation.OR
    var isFilterApplied = false
    
    func getEvents() {
        loading = true
        repository.getEventsList { [weak self] events in
            self?.events = events
            self?.loading = false
        } faildHandler: { [weak self] error in
            self?.error = error ?? ""
            self?.loading = false
        }
    }
    
    func applyFilters(city: String, price: String) {
        if !city.isEmpty || !price.isEmpty {
            isFilterApplied = true
            filteredEvents = events.filter({ event in
                if !city.isEmpty && !price.isEmpty {
                    let price = Int(price) ?? 0
                    switch filterOperation {
                    case .AND:
                        return event.city?.lowercased().contains(city.lowercased()) ?? false && (event.price ?? 0) <= price
                    case .OR:
                        return event.city?.lowercased().contains(city.lowercased()) ?? false || (event.price ?? 0) <= price
                    }
                } else if !city.isEmpty {
                    return event.city?.lowercased().contains(city.lowercased()) ?? false
                } else {
                    let price = Int(price) ?? 0
                    return (event.price ?? 0) <= price
                }
            })
        } else {
            clearFilter()
        }
    }
    
    func clearFilter() {
        isFilterApplied = false
        filteredEvents = []
    }
}
