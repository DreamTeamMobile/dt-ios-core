//
//  Sequence+Extensions.swift
//
//  Copyright © 2019 DreamTeamMobile. All rights reserved.
//

import Foundation

public extension Sequence {
    
    func groupSort(ascending: Bool = true, byDate dateKey: (Iterator.Element) -> Date, byComponent component: Calendar.Component) -> [[Iterator.Element]] {
        var categories: [[Iterator.Element]] = []
        for element in self {
            let key = dateKey(element)
            guard let dayIndex = categories.firstIndex(where: { $0.contains(where: { Calendar.current.isDate(dateKey($0), equalTo: key, toGranularity: component) }) }) else {
                guard let nextIndex = categories.firstIndex(where: { $0.contains(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) }) else {
                    categories.append([element])
                    continue
                }
                categories.insert([element], at: nextIndex)
                continue
            }

            guard let nextIndex = categories[dayIndex].firstIndex(where: { dateKey($0).compare(key) == (ascending ? .orderedDescending : .orderedAscending) }) else {
                categories[dayIndex].append(element)
                continue
            }
            categories[dayIndex].insert(element, at: nextIndex)
        }
        
        return categories
    }
    
    func sum<T: Numeric>(byKey keyFunc: (Iterator.Element) -> T) -> T {
        var sum: T = 0
        self.forEach { element in
            sum += keyFunc(element)
        }
        return sum
    }
        
}
