//
//  PopCitiesView.swift
//  korusell
//
//  Created by Sergey Li on 12/14/23.
//

import SwiftUI

struct PopCitiesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCities: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Фильтр по городам")
                    .font(bold17f)
                    .bold()
                Spacer()
                Button(action: {
                    popCities = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
                .foregroundColor(.gray1000)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 15)
        
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.cities.sorted(by: { $0.id < $1.id }), spacing: 10, alignment: .leading) { city in
                    Button(action: {
                        if city.id == 0 {
                            if !cc.selectedCities.contains(city.id) {
                                cc.selectedCities.removeAll()
//                                cc.selectedCities.append(contentsOf: cc.cities.compactMap({ $0.id }))
                                cc.selectedCities.append(city.id)
                            } else {
                                cc.selectedCities.removeAll()
                            }
                        } else {
                            if !cc.selectedCities.contains(city.id) {
                                cc.selectedCities.append(city.id)
                            } else {
                                if let index = cc.selectedCities.firstIndex(where: { $0 == city.id }) {
                                    cc.selectedCities.remove(at: index)
                                }
                            }
                            
                            if let _ = cc.selectedCities.firstIndex(where: { $0 == 0 }) {
                                // MARK: remove all on unselecting any city
                                cc.selectedCities.removeAll()
                                // MARK: add all except 0 and unselected city
                                cc.selectedCities.append(contentsOf: cc.cities.filter({ $0.id != 0 && $0.id != city.id }).compactMap({ $0.id }))
                            }
                            // MARK: if cc.selectedCities has all cities remove all cities and add only 0
                            if cc.selectedCities.count + 1 >= cc.cities.count {
                                cc.selectedCities.removeAll()
                                cc.selectedCities.append(0)
                            }
                        }
                    }) {
                        // MARK: 0 - all cities
                        LabelView(title: city.ru, isSelected: cc.selectedCities.contains(city.id) || cc.selectedCities.contains(0))
                    }
                }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
        .cornerRadius(30)
        .padding(.horizontal, 22)
    }
}

struct EditPopCitiesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var user: Contact
    @Binding var popCities: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("ГОРОДА")
                .foregroundColor(.gray1000)
                .font(bold17f)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 22)
                .padding(.top, 22)
        
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.cities.sorted(by: { $0.id < $1.id }), spacing: 10, alignment: .leading) { city in
                    Button(action: {
                        if city.id == 0 {
                            if !user.cities.contains(city.id) {
                                user.cities.removeAll()
//                                user.cities.append(contentsOf: cc.cities.compactMap({ $0.id }))
                                user.cities.append(city.id)
                            } else {
                                user.cities.removeAll()
                            }
                        } else {
                            if !user.cities.contains(city.id) {
                                user.cities.append(city.id)
                            } else {
                                if let index = user.cities.firstIndex(where: { $0 == city.id }) {
                                    user.cities.remove(at: index)
                                }
                            }
                            
                            if let _ = user.cities.firstIndex(where: { $0 == 0 }) {
                                // MARK: remove all on unselecting any city
                                user.cities.removeAll()
                                // MARK: add all except 0 and unselected city
                                user.cities.append(contentsOf: cc.cities.filter({ $0.id != 0 && $0.id != city.id }).compactMap({ $0.id }))
                            }
                            // MARK: if user.cities has all cities remove all cities and add only 0
                            if user.cities.count + 1 >= cc.cities.count {
                                user.cities.removeAll()
                                user.cities.append(0)
                            }
                        }
                    }) {
                        // MARK: 0 - all cities
                        LabelView(title: city.ru, isSelected: user.cities.contains(city.id) || user.cities.contains(0))
                    }
                }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
        .cornerRadius(30)
        .padding(.horizontal, 22)
    }
}

//#Preview {
//    PopCitiesView()
//}
