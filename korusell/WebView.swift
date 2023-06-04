//
//  WebView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/02.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
