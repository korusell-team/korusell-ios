//
//  Member.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import Foundation

struct Member: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let surname: String
    
    var description: String {
        return self.surname + " " + self.name
    }
}
