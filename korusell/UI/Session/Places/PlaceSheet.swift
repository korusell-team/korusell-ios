//
//  PlaceSheet.swift
//  korusell
//
//  Created by Sergey Li on 1/8/24.
//

import SwiftUI
import CachedAsyncImage
import UniformTypeIdentifiers

struct PlaceSheet: View {
    @EnvironmentObject var cc: ContactsController
    
    @State var alertIsPresented = false
    
    let place: PlacePoint
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                let url = place.smallImages.first ?? ""
                CachedAsyncImage(url: URL(string: url), urlCache: .imageCache) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                        //                                        .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 65, maxHeight: 65)
                            .transition(.scale(scale: 0.1, anchor: .center))
                    case .failure:
                        Image(systemName: "💼")
                            .font(bold30f)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 65, height: 65)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .contentShape(ContentShapeKinds.contextMenuPreview, RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(place.name ?? "")
                            .font(semiBold18f)
                            .foregroundColor(.gray1100)
                            .padding(.bottom, 3)
                        
                        Spacer()
                        
                        Button(action: { PhoneHelper.shared.call(place.phone ?? "") }) {
                            Image(systemName: "phone.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                                .frame(width: 40, height: 40)
                        }
                        .disabled(place.phone == nil)
                        .opacity(place.phone != nil ? 1 : 0.5)
                        
                        Button(action: { PhoneHelper.shared.sendSMS(place.phone ?? "") }) {
                            Image(systemName: "message.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                                .frame(width: 40, height: 40)
                        }
                        .disabled(place.phone == nil)
                        .opacity(place.phone != nil ? 1 : 0.5)
                    }
                    
                    if let address = place.address {
                        HStack {
                            Image(systemName: "pin.circle.fill")
                            Text(address)
                                .font(regular15f)
//                                .foregroundColor(.gray900)
                                .lineLimit(1)
                        }.onTapGesture {
                            UIPasteboard.general.setValue(address as Any,
                                                          forPasteboardType: UTType.plainText.identifier)
                            alertIsPresented = true
                        }
                        .alert(isPresented: $alertIsPresented) {
                            Alert(title: Text("адрес: '\(address)' скопирован в буфер обмена"))
                        }
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    /// getting only sub categories
                    ForEach(place.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                        /// matching category int with categories from db
                        let category = cc.cats.first(where: { $0.id == cat }) ??
                        Category(id: 11110, title: "bug", p_id: 1, emoji: "👾")
                        Text(category.emoji + "  " + category.title)
                            .tracking(-0.5)
                            .font(semiBold12f)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .overlay(
                                        Capsule(style: .continuous)
                                                .stroke(Color.gray200, lineWidth: 1)
                                    )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.vertical, 4)
                    }
                }
            }
            .foregroundColor(.gray1000)
            
            Divider().padding(.vertical, 10)
            
            if let bio = place.bio, !bio.isEmpty {
                Text(bio)
                    .font(regular13f)
                    .foregroundColor(.gray800)
                    .lineLimit(2)
                    .padding(.bottom)
            }
            
            HStack {
                Spacer()
                Button(action: action) {
                    Text("Подробнее")
                        .font(semiBold16f)
                        .foregroundColor(.app_white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.gray900)
                        .cornerRadius(18)
                }
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .background(Color.app_white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal, 22)
    }
}

#Preview {
    PlaceSheet(place: dummyPlaces.first!, action: {})
}
