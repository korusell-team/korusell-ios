//
//  ContactsController.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/15.
//

import SwiftUI

class ContactsController: ObservableObject {
    @Published var searchFocused: Bool = false
    @Published var text = ""
    @Published var selectedCategory: Category? = nil
    
    func resetState() {
        withAnimation {
            self.searchFocused = false
            self.text = ""
            self.selectedCategory = nil
        }
    }
    
    var filteredCategories: [Category] {
        guard !text.isEmpty else { return listOfCategories }
        
        return listOfCategories.filter { category in
            category.name.lowercased().contains(text.lowercased()) ||
            !category.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
        }
    }
    
    var filteredMembers: [Member] {
        guard !text.isEmpty else { return listOfMembers.sorted(by: { $0.surname < $1.surname}) }
        
        return listOfMembers.filter { member in
            member.name.lowercased().contains(text.lowercased()) ||
            member.surname.lowercased().contains(text.lowercased()) ||
            !member.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
        }.sorted(by: { $0.surname < $1.surname})
    }
    
    var filteredPlaces: [Place] {
        guard !text.isEmpty else { return listOfPlaces.sorted(by: { $0.name < $1.name}) }
        
        return listOfPlaces.filter { place in
            place.name.lowercased().contains(text.lowercased()) ||
            !place.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
        }.sorted(by: { $0.name < $1.name})
    }
}
