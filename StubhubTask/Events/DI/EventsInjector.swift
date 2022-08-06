//
//  EventsInjector.swift
//  StubhubTask
//
//  Created by Hesham Donia on 04/08/2022.
//

import Foundation

class EventsInjector {
    class func provideEventsViewModel() -> EventsViewModel {
        return EventsViewModel(repository: EventsInjector.provideEventsRepository())
    }
    
    class func provideEventsRepository() -> EventsRepository {
        return EventsRepositoryImpl()
    }
}
