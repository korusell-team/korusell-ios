//
//  Functions.swift
//  korusell
//
//  Created by Sergey Li on 2/16/24.
//

import Foundation

func filterCategoryByTags(data: [Category], subs: String) -> [Category] {
    return data.filter { innerArray in
        innerArray.tags.contains { element in
            element.contains(subs)
        }
    }
}
