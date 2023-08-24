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
            !category.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
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
                && !contact.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
            }
            .sorted(by: { $0.surname < $1.surname})
        }
    }
    
    var filteredPlaces: [Place] {
        guard !text.isEmpty else { return listOfPlaces.sorted(by: { $0.name < $1.name}) }
        
        return listOfPlaces.filter { place in
            place.name.lowercased().contains(text.lowercased()) ||
            !place.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
        }.sorted(by: { $0.name < $1.name})
    }
    
    func selectCategory(category: Category) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedCategory == category {
                self.selectedCategory = nil
                self.text = ""
            } else {
                self.selectedCategory = category
                self.text = ""
            }
        }
    }
    
    func thisCategorySelected(category: Category) -> Bool {
        self.selectedCategory == category
    }
    
    func selectSubcategory(text: String) {
        let selected = self.text == text
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if selected {
                self.text = ""
            } else {
                self.text = text
            }
            self.openAllCategories = false
        }
    }
    
    func thisSubcategorySelected(text: String) -> Bool {
        self.text == text
    }
    
    // MARK: Filter for search
    //        guard !text.isEmpty else { return listOfContacts.sorted(by: { $0.surname < $1.surname}) }
    
    //        return listOfContacts.filter { contact in
    //            contact.name.lowercased().contains(text.lowercased()) ||
    //            contact.surname.lowercased().contains(text.lowercased()) ||
    //            !contact.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
    //        }.sorted(by: { $0.surname < $1.surname})
    
}
