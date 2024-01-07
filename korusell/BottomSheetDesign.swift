//
//  BottomSheetDesign.swift
//  korusell
//
//  Created by Sergey Li on 1/4/24.
//

import SwiftUI


struct BottomSheetDesign: View {
    
    @State var showSheet: Bool? = nil
    
    var body: some View {
        
        Button(action: { showSheet = true }) {
            
            HStack (spacing: 5) {
                
                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text("me to bring up adjustable sheet")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            
        }
        .halfSheet(showSheet: $showSheet) {
            
            ZStack {
                
                Color.blue
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .frame(width: 50, height: 8)
                            .padding(.top, -20)
                            .foregroundColor(.black.opacity(0.2))
                        
                        Text("Hello half sheet 🥹")
                            .font(.system(size: 25, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 70)
                            .padding(.bottom, 10)
                        
                        Button(action: { showSheet = false }) {
                            
                            HStack(spacing: 5) {
                                
                                Image(systemName: "hand.tap.fill")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("me to close sheet")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                        }
                    }
                    .padding(.top, 30)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        } onDismiss: {
            print("sheet dismissed")
        }
    }
}

struct BottomSheetDesign_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetDesign()
    }
}
