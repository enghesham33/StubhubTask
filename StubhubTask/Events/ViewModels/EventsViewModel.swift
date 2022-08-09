//
//  EventsViewModel.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

class EventsViewModel: BaseViewModel, ObservableObject {
    
    private var events: [Event] = []
    @Published var filteredEvents: [Event] = []
    
    init(repository: EventsRepository) {
        self.repository = repository
    }
    
    private let repository: EventsRepository
    var filterOperation = FilterOperation.OR
    
    func getEvents() {
        repository.getEventsList { [weak self] events in
            self?.events = events
            self?.filteredEvents = events
        } faildHandler: { [weak self] error in
            self?.error = error ?? ""
        }
    }
    
    func applyFilters(city: String, price: String) {
        
        if city.isEmpty && price.isEmpty {
            clearFilter()
        } else {
            filteredEvents.removeAll()
            switch filterOperation {
            case .AND:
                if !city.isEmpty {
                    filteredEvents = applyCityFilter(events: events, city: city)
                }
                if !price.isEmpty {
                    filteredEvents = applyPriceFilter(events: filteredEvents, price: price)
                }
                
            case .OR:
                if !city.isEmpty {
                    filteredEvents = applyCityFilter(events: events, city: city)
                }
                if !price.isEmpty {
                    filteredEvents.append(contentsOf: applyPriceFilter(events: events, price: price))
                }
            }
        }
    }
    
    func clearFilter() {
        filteredEvents = events
    }
    
    private func applyCityFilter(events: [Event], city: String) -> [Event] {
        return events.filter { event in
            event.city?.lowercased().contains(city.lowercased()) ?? false
        }
    }
    
    private func applyPriceFilter(events: [Event], price: String) -> [Event] {
        let price = Int(price) ?? 0
        return events.filter { event in
            (event.price ?? 0) <= price
        }
    }
}
