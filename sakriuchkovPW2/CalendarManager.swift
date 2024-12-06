//
//  CalendarManager.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 07.12.2024.
//

import EventKit

final class CalendarManager: CalendarManaging {
    // Хранилище событий
    private let eventStore: EKEventStore = EKEventStore()
    
    // MARK: - Синхронное создание события
    func create(eventModel: CalendarEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        
        group.wait()
        return result
    }
    
    // MARK: - Асинхронное создание события
    func create(eventModel: CalendarEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted, error) in
            guard granted, error == nil, let self = self else {
                completion?(false)
                return
            }
            
            let event = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.note
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
                completion?(true)
            } catch let error as NSError {
                print("Failed to save event with error: \(error.localizedDescription)")
                completion?(false)
            }
        }
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}
