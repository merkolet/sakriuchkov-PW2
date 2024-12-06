//
//  ModelCalendar.swift
//  sakriuchkovPW2
//
//  Created by Sergey on 07.12.2024.
//

import UIKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel {
    var title: String
    var startDate: Date
    var endDate: Date
    var note: String?
}
