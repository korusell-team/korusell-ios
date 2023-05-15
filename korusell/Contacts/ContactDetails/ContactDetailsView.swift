//
//  ContactDetailsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/15.
//

import SwiftUI

struct ContactDetailsView: View {
    @State var offset: CGFloat = 0
    
    var member: Member = Member(name: "Andrew", surname: "Garfield", nickname: "garfi90")
    var body: some View {
        TrackableScrollView(.vertical, showIndicators: false, contentOffset: $offset) {
            VStack {
                ZStack {
                    Image("portrait")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - offset)
                        .cornerRadius(offset * 2)
                    LinearGradient(colors: [.white, .clear, .clear], startPoint: .bottom, endPoint: .top)
                    
                    VStack {
                        HStack {
                            Text(member.name)
                                .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            Text(member.surname)
                                .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                        }
                        .foregroundColor(.gray1100)
                        .font(.title2)
                            
                        Text("@" + member.nickname)
                            .foregroundColor(.gray500)
                            .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            .padding(.bottom)
                        HStack(spacing: 20) {
                            VStack {
                                Text("44")
                                    .foregroundColor(.gray900)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                                Text("Места")
                                    .foregroundColor(.gray500)
                                    .font(.caption)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            }.frame(width: 75, alignment: .trailing)
                            Divider().frame(height: 30)
                                .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            VStack {
                                Text("44")
                                    .foregroundColor(.gray900)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                                Text("Публикаций")
                                    .foregroundColor(.gray500)
                                    .font(.caption)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            }.frame(width: 75)
                            Divider().frame(height: 30)
                                .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            VStack {
                                Text("44")
                                    .foregroundColor(.gray900)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                                Text("Избранный")
                                    .foregroundColor(.gray500)
                                    .font(.caption)
                                    .shadow(color: .gray100, radius: 1, x: 1, y: 1)
                            }.frame(width: 75, alignment: .leading)
                        }.padding(.bottom)
                        
                        HStack {
                            HStack {
                                Text("Нравиться")
                                    .font(.caption)
                                Image(systemName: "heart")
                            }.padding(10)
                                .background(Color.red300)
                                .cornerRadius(25)
                            
                            HStack {
                                Text("Избранный")
                                    .font(.caption)
                                Image(systemName: "bookmark")
                            }.padding(10)
                                .background(Color.yellow400)
                                .cornerRadius(25)
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                VStack {
                    HStack {
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                    HStack {
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                    HStack {
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                    HStack {
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                        Color.yellow400
                            .frame(height: 200)
                            .cornerRadius(10)
                    }
                }.padding()
            }.onChange(of: offset) { offset in
                print(offset)
            }
        }.ignoresSafeArea()
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailsView()
    }
}
