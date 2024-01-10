//
//  ContentViewController.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI

class SessionViewController: ObservableObject {
    @Published var selectedIndex: Int = 0
    @Published var showBottomBar = true
}
