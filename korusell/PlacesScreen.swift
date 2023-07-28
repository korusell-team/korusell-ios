//
//  PlacesScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI

struct PlacesScreen: View {
    @Environment(\.openURL) var openURL
    
    @State var selectedPlace: PlacePoint? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(selectedPlace: $selectedPlace)
        }
        .ignoresSafeArea()
        .sheet(item: $selectedPlace) { place in
            VStack {
                Text(place.title ?? "")
                    .font(largeTitleFont)
                    .padding()
                Text("🚧 здесь нужен дизайн...")
                
                if let address = place.address {
                    // Create the URL with query items
                   
                           
                    
                    Button(address) {
                                openURL(createKakaoUrl(address: address))
                            }
                    .padding()
//                    Link(destination: URL(string: urlString) ?? URL(string: "https://map.kakao.com")! ) {
//                        Text(address)
//                            .font(calloutFont)
//                            .foregroundColor(.blue400)
//                            .onAppear {
//                                print(urlString)
//                            }
//                    }
                    .padding(.bottom, 5)
                }
                
            }
            .onDisappear {
                print("Disappear")
                selectedPlace = nil
            }
        }
    }
    
    func stringToEuckrString(stringValue: String) -> String {

        let encoding:UInt = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(
            CFStringEncodings.ISO_2022_KR.rawValue))

        let encodedData = stringValue.data(using: String.Encoding(rawValue: encoding))!

        let attributedString = try? NSAttributedString(data: encodedData, options:[:],        documentAttributes: nil)

        if let _ = attributedString {
            return attributedString!.string
        } else {
            return ""
        }
    }
    
    private func createKakaoUrl(address: String) -> URL {
        
        let encodedAddress = stringToEuckrString(stringValue: address)
        let urlString = "https://map.kakao.com/?q=" + encodedAddress
//        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(encodedAddress)
        let url = URL(string: urlString)!
//        var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        print(urlString)
        return url
        
        //        var urlComps = URLComponents(string: "https://map.kakao.com/")!
//                var urlComps = URLComponents(url: URL(string: "https://map.kakao.com/")!, resolvingAgainstBaseURL: true)!
//        let queryItems = [URLQueryItem(name: "q", value: encodedAddress)]
//        urlComps.queryItems = queryItems
//        print(urlComps.url)
//        return urlComps.url!
    }
}

struct PlacesScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlacesScreen()
    }
}
