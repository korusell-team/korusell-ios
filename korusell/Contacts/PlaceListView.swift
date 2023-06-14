//
//  PlaceListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/04.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var cc: ContactsController
    @State var collapsed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("🗺️ Места")
                    .tracking(-1)
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: collapsed ? 180 : 0))
                }
            .foregroundColor(.gray1100)
            .padding(.horizontal, 30)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    collapsed.toggle()
                }
            }

            if !collapsed {
                if !cc.filteredPlaces.isEmpty {
                    ForEach(cc.filteredPlaces, id: \.self) { place in
                        PlaceView(place: place)
                    }
                } else {
                    Text("🙈 Список пуст...")
                        .foregroundColor(.gray300)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                }
            }
        }.frame(maxWidth: UIScreen.main.bounds.width)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        PlaceListView()
                .environmentObject(cc)
    }
}
