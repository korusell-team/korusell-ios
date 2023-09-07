//
//  ContactsController.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/15.
//

import SwiftUI

class ContactsController: ObservableObject {
    @Published var searchFocused: Bool = false
    @Published var selectedSubcategory: String? = nil
    @Published var selectedCategory: Category? = nil
    @Published var city: String? = nil
    @Published var openAllCategories = false
    
    
    
    func resetState() {
        withAnimation {
            self.searchFocused = false
            self.selectedSubcategory = nil
            self.selectedCategory = nil
        }
    }
    
    var filteredCategories: [Category] {
        guard selectedSubcategory != nil else { return listOfCategories }
        
        return listOfCategories.filter { category in
            category.name.lowercased().contains(selectedSubcategory!.lowercased()) ||
            !category.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty
        }
    }
    
    var filteredContacts: [Contact] {
        return listOfContacts.filter { contact in
            ( (city != nil) ? !contact.cities.filter { $0.lowercased().contains(city!.lowercased()) }.isEmpty : true) &&
            ( (selectedCategory != nil) ? !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty : true) &&
            ( (selectedSubcategory != nil) ? !contact.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty : true)
        }
        .sorted(by: { $0.surname < $1.surname})
        
        
//        if selectedSubcategory.isEmpty {
//            return listOfContacts.filter { contact in
//                !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty
//                && ( (city != nil) ? !contact.cities.filter { $0.lowercased().contains(city!.lowercased()) }.isEmpty : true)
//            }
//            .sorted(by: { $0.surname < $1.surname})
//        } else {
//            return listOfContacts.filter { contact in
//                !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty
//                && !contact.subcategories.filter { $0.lowercased().contains(selectedSubcategory.lowercased()) }.isEmpty
//                && ( (city != nil) ? !contact.cities.filter { $0.lowercased().contains(city!.lowercased()) }.isEmpty : true)
//            }
//            .sorted(by: { $0.surname < $1.surname})
//        }
    }
    
    var filteredPlaces: [Place] {
        guard selectedSubcategory != nil else { return listOfPlaces.sorted(by: { $0.name < $1.name}) }
        
        return listOfPlaces.filter { place in
            place.name.lowercased().contains(selectedSubcategory!.lowercased()) ||
            !place.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty
        }.sorted(by: { $0.name < $1.name})
    }
    
    func selectCategory(category: Category) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedCategory == category {
                self.selectedCategory = nil
                self.selectedSubcategory = nil
            } else {
                self.selectedCategory = category
                self.selectedSubcategory = nil
            }
        }
    }
    
    func thisCategorySelected(category: Category) -> Bool {
        self.selectedCategory == category
    }
    
    func selectSubcategory(text: String) {
        let selected = self.selectedSubcategory == text
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if selected {
                self.selectedSubcategory = nil
            } else {
                self.selectedSubcategory = text
            }
            self.openAllCategories = false
        }
    }
    
    func thisSubcategorySelected(text: String) -> Bool {
        self.selectedSubcategory == text
    }
    
    // MARK: Filter for search
    //        guard !text.isEmpty else { return listOfContacts.sorted(by: { $0.surname < $1.surname}) }
    
    //        return listOfContacts.filter { contact in
    //            contact.name.lowercased().contains(text.lowercased()) ||
    //            contact.surname.lowercased().contains(text.lowercased()) ||
    //            !contact.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
    //        }.sorted(by: { $0.surname < $1.surname})
    
}
