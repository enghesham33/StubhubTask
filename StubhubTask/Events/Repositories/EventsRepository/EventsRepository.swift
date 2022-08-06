//
//  EventsRepository.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import Foundation

protocol EventsRepository {
    func getEventsList(completionHandler: @escaping ([Event]) -> (), faildHandler: @escaping (String?) -> Void)
}

class EventsRepositoryImpl: EventsRepository {
    
    func getEventsList(completionHandler: @escaping ([Event]) -> (), faildHandler: @escaping (String?) -> Void) {
        JsonFileManager.instance.requestJsonData(fileName: "events") { [weak self] response in
            do {
                if let response = response {
                    let child = try JSONDecoder().decode(Child.self, from: response)
                    completionHandler(self?.getEvents(children: child.children ?? []) ?? [])
                }
            } catch let error {
                faildHandler(error.localizedDescription)
            }
        } errorHandler: { error in
            faildHandler(error)
        }
    }
    
    private func getEvents(children: [Child]) -> [Event] {
        var eventsList = [Event]()
        for child in children {
            if (child.children ?? []).count > 0 {
                eventsList.append(contentsOf: getEvents(children: child.children ?? []))
            } else {
                eventsList.append(contentsOf: child.events ?? [])
            }
        }
        return eventsList
    }
}
