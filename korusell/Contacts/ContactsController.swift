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

//    @Published var currentUser: Contact = Contact(uid: "", name: "Sergey", surname: "Lee", bio: "iOS Developer", cities: ["Ансан", "Сеул"], image: ["https://firebasestorage.googleapis.com/v0/b/inkorea-bfee4.appspot.com/o/sergey-lee.jpeg?alt=media&token=04a3e9bd-f9fc-444f-86e3-d5661a36e5e4"], categories: ["IT"], subcategories: ["iOS"], phone: "+821012341", instagram: "k0jihero", telegram: "k0jihero", kakao: "k0jihero")
    @Published var contacts: [Contact] = []
    @Published var categories: [Category] = []
    @Published var cities: [City] = []
    
    init() {
        loadContacts()
        loadCategories()
        loadCities()
    }
    
    func loadContacts() {
        if let url = Bundle.main.url(forResource: "contacts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let contacts = try decoder.decode([Contact].self, from: data)
                self.contacts = contacts
                print(self.contacts)
            } catch {
                print("error:\(error)")
                self.contacts = dummyContacts
            }
        }
    }
    
    func loadCategories() {
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let categories = try decoder.decode([Category].self, from: data)
                self.categories = categories
            } catch {
                print("error:\(error)")
                self.categories = DummyCategories
            }
        }
    }
    
    func loadCities() {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let cities = try decoder.decode([City].self, from: data)
                self.cities = cities
            } catch {
                print("error:\(error)")
                return self.cities = dummyCities
            }
        }
    }
    
    func resetState() {
        withAnimation {
            self.searchFocused = false
            self.selectedSubcategory = nil
            self.selectedCategory = nil
        }
    }
    
    var filteredCategories: [Category] {
        guard selectedSubcategory != nil else { return categories }
        
        return categories.filter { category in
            category.name.lowercased().contains(selectedSubcategory!.lowercased()) ||
            !category.subCategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty
        }
    }
    
    var filteredContacts: [Contact] {
        return contacts.filter { contact in
            ( (city != nil) ? !contact.cities.filter { $0.lowercased().contains(city!.lowercased()) }.isEmpty : true) &&
            ( (selectedCategory != nil) ? !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty : true) &&
            ( (selectedSubcategory != nil) ? !contact.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty : true)
        }
        .sorted(by: { $0.surname ?? "" < $1.surname ?? ""})
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
