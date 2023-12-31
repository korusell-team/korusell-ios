//
//  ContactsController.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/15.
//

import SwiftUI
import FirebaseFirestore

class ContactsController: ObservableObject {
    @Published var searchFocused: Bool = false
    @Published var selectedSubcategory: Category? = nil
    @Published var selectedCategory: Category? = nil
    @Published var selectedCities: [Int] = []
    @Published var openAllCategories = false
    
    /// all categories
    @Published var cats: [Category] = []
    /// filtered categories
    @Published var categories: [Category] = []
    @Published var subCategories: [Category] = []
    @Published var searchCategories: [Category] = []
    @Published var searchCategoriesFull: [Category] = []
    /// all users
    @Published var users: [Contact] = []
    /// filtered users
    @Published var contacts: [Contact] = []
    
    @Published var cities: [City] = []
    
    private var db = Firestore.firestore()
    
    init() {
        print("Concatcts Controller initialization")
        self.getCats()
        self.getCities()
        self.getUsers()
    }
    
    func getCats() {
        db
            .collection("cats")
            .getDocuments{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print(error?.localizedDescription)
                    print("No cats! 🐾")
                    return
                }
                
                self.cats = documents.compactMap { queryDocumentSnapshot -> Category? in
                    do {
                        return try queryDocumentSnapshot.data(as: Category.self)
                    } catch {
                        print("Error decoding document into Category object: \(error)")
                        return nil
                    }
                }
                print("Successfullly got cats 🐾")
                self.categories = self.cats.filter({ $0.p_id <= 0 }).sorted(by: { $0.title < $1.title })
                self.searchCategories = self.cats.filter({ $0.p_id > 0 })
                self.searchCategoriesFull = self.cats.filter({ $0.p_id > 0 })
            }
    }
    
    func getCities() {
        db
            .collection("cities")
            .getDocuments{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No cities! 🏙️")
                    return
                }
                guard !documents.isEmpty else {
                    print("No cities! 🏙️")
                    return
                }
                self.cities = documents.compactMap { queryDocumentSnapshot -> City? in
                    do {
                        return try queryDocumentSnapshot.data(as: City.self)
                    } catch {
                        print("Error decoding document into City object: \(error)")
                        return nil
                    }
                }
                print("Successfullly got cities 🏙️")
            }
    }
    
    func getUsers() {
        db
            .collection("users")
            .getDocuments{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No users! 🤦🏻")
                    return
                }
                
                let users = documents.compactMap { queryDocumentSnapshot -> Contact? in
                    do {
                        return try queryDocumentSnapshot.data(as: Contact.self)
                    } catch {
                        print("Error decoding document into User object: \(error)")
                        return nil
                    }
                }
                print("Successfullly got users 🤦🏻")
                self.users = users.filter({ $0.isPublic })
                self.contacts = self.users.shuffled().sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
            }
    }
    
    func selectCategory(category: Category, reader: ScrollViewProxy) {
        withAnimation {
//        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedCategory == category {
                self.selectedCategory = nil
                self.selectedSubcategory = nil
                self.subCategories = []
                self.contacts = cityFilter(contacts: self.users)
                reader.scrollTo(self.categories.first?.id, anchor: .center)
            } else {
                self.selectedCategory = category
                self.subCategories = self.cats.filter({ $0.p_id == self.selectedCategory?.id })
                self.selectedSubcategory = nil
                self.contacts = cityFilter(contacts: self.users.filter({ $0.categories.contains(where: { $0.divider() == category.id.divider() }) }))
                reader.scrollTo(category.id, anchor: .center)
            }
        }
    }
    
    func selectSubCategory(subCat: Category, reader: ScrollViewProxy) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedSubcategory == subCat {
                self.selectedSubcategory = nil
                if let selectedCategory {
                    self.contacts = cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == subCat.id.divider() }) }))
                    /// never gonna happen ?
                } else {
                    self.contacts = cityFilter(contacts: self.users)
                }
                reader.scrollTo(self.subCategories.first?.id, anchor: .center)
            } else {
                self.selectedSubcategory = subCat
                self.contacts = cityFilter(contacts: self.users.filter({ $0.categories.contains(subCat.id) }))
                reader.scrollTo(subCat.id, anchor: .center)
            }
        }
    }
    
    func triggerCityFilter() {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if let selectedSubcategory {
                if let selectedCategory {
                    self.contacts = cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == selectedSubcategory.id.divider() }) }))
                    /// never gonna happen ?
                } else {
                    self.contacts = cityFilter(contacts: self.users)
                }
            } else {
                if let selectedCategory {
                    self.contacts = cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == selectedCategory.id.divider() }) }))
                    /// never gonna happen ?
                } else {
                    self.contacts = cityFilter(contacts: self.users)
                }
            }
        }
    }

    func cityFilter(contacts: [Contact]) -> [Contact] {
        if #available(iOS 16.0, *) {
            guard !self.selectedCities.isEmpty && !self.selectedCities.contains(0) else { return contacts }
            
            return contacts.filter({
//                print(self.selectedCities.contains($0.cities))
//                print(self.selectedCities)
//                print($0.cities)
                
                return self.selectedCities.contains($0.cities)
            }) +
            contacts.filter({ $0.cities.contains(0) })
            
        } else {
            return contacts
        }
    }
    
//    func filterData() {
//        db.collection("users")
//            .whereField("categories", arrayContains: selectedCategory?.id)
//            .addSnapshotListener { (querySnapshot, error) in
//                guard let documents = querySnapshot?.documents else {
//                    print("No documents")
//                    return
//                }
//
//                self.contacts = documents.compactMap { queryDocumentSnapshot -> Contact? in
//                    do {
//                        return try queryDocumentSnapshot.data(as: Contact.self)
//                    } catch {
//                        print("Error decoding document into Service: \(error)")
//                        return nil
//                    }
//                }
//            }
//    }
        
//    func loadContacts() {
//        if let url = Bundle.main.url(forResource: "contacts", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let contacts = try decoder.decode([Contact].self, from: data)
//                self.contacts = contacts
//                print(self.contacts)
//            } catch {
//                print("error:\(error)")
//                self.contacts = dummyContacts
//            }
//        }
//    }
    
    /// from json
//    func loadCategories() {
//        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let categories = try decoder.decode([Category].self, from: data)
//                self.categories = categories
//            } catch {
//                print("error:\(error)")
////                self.categories = DummyCategories
//            }
//        }
//    }
    /// from json
//    func loadCities() {
//        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let cities = try decoder.decode([City].self, from: data)
//                self.cities = cities
//            } catch {
//                print("error:\(error)")
//                return self.cities = dummyCities
//            }
//        }
//    }
    
//    func resetState() {
//        withAnimation {
//            self.searchFocused = false
//            self.selectedSubcategory = nil
//            self.selectedCategory = nil
//        }
//    }
    
//    var filteredCategories: [Category] {
//        guard selectedSubcategory != nil else { return categories }
        
//        return categories.filter { category in
//            category.title.lowercased().contains(selectedSubcategory!.title.lowercased()) ||
//            !category.subCategories.filter { $0.title.lowercased().contains(selectedSubcategory!.title.lowercased()) }.isEmpty
//        }
//    }
    
//    var filteredContacts: [Contact] {
//        return contacts.filter { contact in
//            ( (city != nil) ? !contact.cities.filter { $0.lowercased().contains(city!.lowercased()) }.isEmpty : true) &&
//            ( (selectedCategory != nil) ? !contact.categories.filter { $0.lowercased().contains(selectedCategory!.name.lowercased()) }.isEmpty : true) &&
//            ( (selectedSubcategory != nil) ? !contact.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.lowercased()) }.isEmpty : true)
//        }
//        .sorted(by: { $0.surname ?? "" < $1.surname ?? ""})
//    }
    
    var filteredPlaces: [Place] {
        guard selectedSubcategory != nil else { return listOfPlaces.sorted(by: { $0.name < $1.name}) }
        
        return listOfPlaces.filter { place in
            place.name.lowercased().contains(selectedSubcategory!.title.lowercased()) ||
            !place.subcategories.filter { $0.lowercased().contains(selectedSubcategory!.title.lowercased()) }.isEmpty
        }.sorted(by: { $0.name < $1.name})
    }
    
    /// Filter for search
    //        guard !text.isEmpty else { return listOfContacts.sorted(by: { $0.surname < $1.surname}) }
    
    //        return listOfContacts.filter { contact in
    //            contact.name.lowercased().contains(text.lowercased()) ||
    //            contact.surname.lowercased().contains(text.lowercased()) ||
    //            !contact.subcategories.filter { $0.lowercased().contains(text.lowercased()) }.isEmpty
    //        }.sorted(by: { $0.surname < $1.surname})
    
}
///  simple function for comparing sub category and category
extension Int {
    func divider() -> Int {
        return self / 100
    }
}
