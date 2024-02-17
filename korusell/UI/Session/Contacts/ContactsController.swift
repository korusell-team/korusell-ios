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
//    @Published var categories: [Category] = []
//    @Published var subCategories: [Category] = []
    /// categories for places
    @Published var categoriesPlaces: [Category] = []
    @Published var subCategoriesPlaces: [Category] = []
    @Published var selectedSubcategoryPlaces: Category? = nil
    @Published var selectedCategoryPlaces: Category? = nil
    @Published var places: [PlacePoint] = []
    @Published var filteredPlaces: [PlacePoint] = []
    
    @Published var searchCategories: [Category] = []
    @Published var searchCategoriesFull: [Category] = []
    @Published var searching: Bool = false
    @Published var searchField: String = ""
    @Published var searchPresented: Bool = false
    @Published var selectedContact: Contact? = nil
    /// all users
    @Published var users: [Contact] = []
    /// filtered users
    //    @Published var contacts: [Contact] = []
    
    @Published var cities: [City] = []
    
    private var db = Firestore.firestore()
    
    init() {
        self.getCats()
        self.getCities()
        self.getUsers()
        self.getPlaces()
    }
    
    var contacts: [Contact] {
        self.users
            .filter({ $0.isPublic })
//            .shuffled()
//            .filter({ !$0.blockedBy.contains(userManager.user?.id ?? "🇰🇵")})
            .filter({ $0.reports.isEmpty })
            .filter({ $0.blockedBy.isEmpty })
            .sorted(by: { $0.likes.count > $1.likes.count })
            .sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
            .filter({ $0.categories.contains(where: { selectedCategory != nil ? $0.divider() == self.selectedCategory?.id.divider() : true }) })
            .filter({ self.selectedSubcategory != nil ? $0.categories.contains(self.selectedSubcategory!.id) : true })
            .filter({ self.selectedSubcategory != nil ? true : (self.searchField.isEmpty ? true : $0.name?.lowercased().contains(self.searchField.lowercased()) ?? false || $0.surname?.lowercased().contains(self.searchField.lowercased()) ?? false) })
    }
    
    var categories: [Category] {
        self.cats
            .filter({ $0.p_id <= 0 }).filter({ $0.id < 2000 }) .sorted(by: { $0.title < $1.title })
    }
    
    var subCategories: [Category] {
        self.cats
            .filter({ $0.p_id > 0 })
            .filter({ self.searchFocused || self.searching ? true : $0.p_id == self.selectedCategory?.id })
            .sorted(by: { $0.title < $1.title })
            .filter { innerArray in
                self.searchField.isEmpty ? true :
                innerArray.tags.contains { element in
                    element.contains(self.searchField)
                }
            }
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
                        print(queryDocumentSnapshot.documentID)
                        return nil
                    }
                }
                print("Successfullly got cats 🐾")
                
//                self.categories = self.cats.filter({ $0.p_id <= 0 }).filter({ $0.id < 2000 }) .sorted(by: { $0.title < $1.title })
                // TODO: remove me . . .
                self.categoriesPlaces = self.cats.filter({ $0.p_id <= 0 }).sorted(by: { $0.title < $1.title })
                self.searchCategories = self.cats.filter({ $0.p_id > 0 })
                self.searchCategoriesFull = self.cats.filter({ $0.p_id > 0 })
                
                if let encoded = try? JSONEncoder().encode(self.cats.filter({ $0.id.divider() > 0 })) {
                    UserDefaults.standard.set(encoded, forKey: "cats")
                }
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
                self.users = users
//                self.users = users.filter({ $0.isPublic })
                //                self.contacts = self.users.shuffled().sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
            }
    }
    
    func getPlaces() {
        db
            .collection("places")
            .getDocuments{ (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No places! 🏖️")
                    return
                }
                
                let places = documents.compactMap { queryDocumentSnapshot -> Place? in
                    do {
                        return try queryDocumentSnapshot.data(as: Place.self)
                    } catch {
                        print("Error decoding document into Place object: \(error)")
                        return nil
                    }
                }
                print("Successfullly got places 🏖️")
                //                print(places)
                self.places = places.map({ $0.toPlacePoint() })
                self.filteredPlaces = self.places
            }
    }
    
    func selectCategory(category: Category, reader: ScrollViewProxy) {
        withAnimation {
            //        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedCategory == category {
                self.selectedCategory = nil
                self.selectedSubcategory = nil
//                self.subCategories = []
                //                    DispatchQueue.main.async {
                //                        self.contacts = self.cityFilter(contacts: self.users)
                //                    }
                reader.scrollTo(self.categories.first?.id, anchor: .center)
            } else {
                self.selectedCategory = category
//                self.subCategories = self.cats.filter({ $0.p_id == self.selectedCategory?.id })
                self.selectedSubcategory = nil
                //                    DispatchQueue.main.async {
                //                        self.contacts = self.cityFilter(contacts: self.users.filter({ $0.categories.contains(where: { $0.divider() == category.id.divider() }) }))
                //                    }
                reader.scrollTo(category.id, anchor: .center)
            }
        }
    }
    
    func resetCategories() {
        withAnimation {
            self.selectedCategory = nil
            self.selectedSubcategory = nil
//            self.subCategories = []
            //                self.contacts = cityFilter(contacts: self.users.shuffled()
            //                    .sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 }))
        }
    }
    
    func filterBySearch() {
//        self.subCategories = filterCategoryByTags(data: self.searchCategoriesFull, subs: self.searchField.lowercased())
//        if searchField.isEmpty {
//            self.contacts = self.users
//                .shuffled()
//                .sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
//        } else {
//            self.contacts = self.users
//                .filter({ $0.name?.lowercased().contains(self.searchField.lowercased()) ?? false || $0.surname?.lowercased().contains(self.searchField.lowercased()) ?? false })
//                .shuffled()
//                .sorted(by: { $0.priority ?? 0 > $1.priority ?? 0 })
//        }
    }
    
    func selectSubCategory(subCat: Category, reader: ScrollViewProxy) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedSubcategory == subCat {
                self.selectedSubcategory = nil
                //                if self.selectedCategory != nil {
                //                    DispatchQueue.main.async {
                //                        self.contacts = self.cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == subCat.id.divider() }) }))
                //                    }
                //                    /// never gonna happen ?
                //                } else {
                //                    self.contacts = self.cityFilter(contacts: self.users)
                //                }
                reader.scrollTo(self.subCategories.first?.id, anchor: .center)
            } else {
                self.selectedSubcategory = subCat
                //                DispatchQueue.main.async {
                //                    self.contacts = self.cityFilter(contacts: self.users.filter({ $0.categories.contains(subCat.id) }))
                //                }
                reader.scrollTo(subCat.id, anchor: .center)
            }
        }
    }
    
    //    func triggerCityFilter() {
    //        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
    //            if let selectedSubcategory {
    //                if let selectedCategory {
    //                    self.contacts = cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == selectedSubcategory.id.divider() }) }))
    //                    /// never gonna happen ?
    //                } else {
    //                    self.contacts = cityFilter(contacts: self.users)
    //                }
    //            } else {
    //                if let selectedCategory {
    //                    self.contacts = cityFilter(contacts:self.users.filter({ $0.categories.contains(where: { $0.divider() == selectedCategory.id.divider() }) }))
    //                    /// never gonna happen ?
    //                } else {
    //                    self.contacts = cityFilter(contacts: self.users)
    //                }
    //            }
    //        }
    //    }
    
    func cityFilter(contacts: [Contact]) -> [Contact] {
        if #available(iOS 16.0, *) {
            guard !self.selectedCities.isEmpty && !self.selectedCities.contains(0) else { return contacts }
            
            return contacts.filter({
                return self.selectedCities.contains($0.cities)
            }) +
            contacts.filter({ $0.cities.contains(0) })
            
        } else {
            return contacts
        }
    }
    
    func selectCategoryPlaces(category: Category, reader: ScrollViewProxy) {
        withAnimation {
            //        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedCategoryPlaces == category {
                self.selectedCategoryPlaces = nil
                self.selectedSubcategoryPlaces = nil
                self.subCategoriesPlaces = []
                self.filteredPlaces = self.places
                reader.scrollTo(self.categoriesPlaces.first?.id, anchor: .center)
            } else {
                self.selectedCategoryPlaces = category
                self.subCategoriesPlaces = self.cats.filter({ $0.p_id == self.selectedCategoryPlaces?.id })
                self.selectedSubcategoryPlaces = nil
                self.filteredPlaces = self.places.filter({ $0.categories.contains(where: { $0.divider() == category.id.divider() }) })
                reader.scrollTo(category.id, anchor: .center)
            }
        }
    }
    
    func selectSubCategoryPlaces(subCat: Category, reader: ScrollViewProxy) {
        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
            if self.selectedSubcategoryPlaces == subCat {
                self.selectedSubcategoryPlaces = nil
                if let selectedCategory {
                    self.filteredPlaces = self.places.filter({ $0.categories.contains(where: { $0.divider() == subCat.id.divider() }) })
                    /// never gonna happen ?
                } else {
                    self.filteredPlaces = self.places
                }
                reader.scrollTo(self.subCategoriesPlaces.first?.id, anchor: .center)
            } else {
                self.selectedSubcategoryPlaces = subCat
                self.filteredPlaces = self.places.filter({ $0.categories.contains(subCat.id) })
                reader.scrollTo(subCat.id, anchor: .center)
            }
        }
    }
}
///  simple function for comparing sub category and category
extension Int {
    func divider() -> Int {
        return self / 100
    }
}
