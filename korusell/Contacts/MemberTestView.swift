//
//  MemberTestView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/05.
//

import SwiftUI

struct MemberTestView: View {
    @State var offset: CGFloat = 0
    @State var animation: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                if animation {
                    ZStack {
                        Color.gray500
                        Text("OS")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } else {
                    Image("portrait-2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
                
                
                Image("ic-phone-call")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .opacity(CGFloat(offset / 130))
                    .rotationEffect(Angle(degrees: -130))
                    .rotationEffect(Angle(degrees: offset))
                Image("ic-messages")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .opacity(CGFloat(offset / 130))
                    .rotationEffect(Angle(degrees: -130))
                    .rotationEffect(Angle(degrees: offset))
            }
            .padding()
            .frame(width: 110 + offset, height: 90, alignment: .leading)
            .background(Color.green10.opacity(CGFloat(offset / 130)))
            .cornerRadius(45)
            
//            if !animation {
                VStack(alignment: .leading) {
                    Text("Olivia Stonefields")
                        .font(.title)
                        .foregroundColor(.gray900)
                    Text("Designer, Influencer")
                        .font(.body)
                        .foregroundColor(.gray600)
                }
                .frame(maxHeight: 100)
                .opacity(animation ? 0 : 1)
//            }
            

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 44, alignment: .leading)
        
        .background(Color.white)
        
//        .gesture(
//              DragGesture()
//                .onChanged { gesture in
//                    if gesture.translation.width > 0 {
//                        self.offset = gesture.translation.width
//                    }
//                    print(gesture.translation.width)
//                }
//                .onEnded { gesture in
//                    withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
//                        if offset > 100 {
//                            offset = 130
//                        } else {
//                            offset = 0
//                        }
//                    }
//
//                    print(gesture.translation.width)
//                }
//            )
        .onTapGesture {
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                offset = offset >= 200 ? 0 : 200
            }
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20).delay(0.05)) {
                animation.toggle()
            }
        }
    }
}

struct MemberTestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MemberTestView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray50)
        
    }
}
