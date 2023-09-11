//
//  JsonHelper.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/10.
//

import Foundation

public struct Throwable<T: Decodable>: Decodable {
    
    public let result: Result<T, Error>

    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Result(catching: catching )
    }
}

struct ListOfContacts: Decodable {
    var contacts: [Contact] = []
  
    enum CodingKeys: String, CodingKey {
        case contacts
    }
}

extension ListOfContacts {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let throwables = try values.decode([Throwable<Contact>].self, forKey: .contacts)

        throwables.forEach {
            switch $0.result {
            case .success(let contact):
                contacts.append(contact)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
