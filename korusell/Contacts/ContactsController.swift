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
    
    @Published var openAllCategories = false
    
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
    
    var filteredContacts: [Contact] {
        guard selectedCategory != nil else { return listOfContacts.sorted(by: { $0.surname < $1.surname}) }
        
        if text.isEmpty {
            return listOfContacts.filter { contact in
                !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty
            }
            .sorted(by: { $0.surname < $1.surname})
        } else {
            return listOfContacts.filter { contact in
                !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty
                && !contact.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
            }
            .sorted(by: { $0.surname < $1.surname})
        }
        
        
        
        
        // MARK: Filter for search
//        guard !text.isEmpty else { return listOfContacts.sorted(by: { $0.surname < $1.surname}) }
        
//        return listOfContacts.filter { contact in
//            contact.name.lowercased().contains(text.lowercased()) ||
//            contact.surname.lowercased().contains(text.lowercased()) ||
//            !contact.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
//        }.sorted(by: { $0.surname < $1.surname})
        
        
    }
    
    var filteredPlaces: [Place] {
        guard !text.isEmpty else { return listOfPlaces.sorted(by: { $0.name < $1.name}) }
        
        return listOfPlaces.filter { place in
            place.name.lowercased().contains(text.lowercased()) ||
            !place.tags.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
        }.sorted(by: { $0.name < $1.name})
    }
}
