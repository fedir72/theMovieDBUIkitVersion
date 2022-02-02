//
//  Utils.swift
//  MVDB-storyboard
//
//  Created by Fedii Ihor on 28.01.2022.
//

import Foundation

class Utils {
 static let jsonDecoder: JSONDecoder = {
    let jDecoder = JSONDecoder()
     jDecoder.keyDecodingStrategy = .convertFromSnakeCase
     jDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    return jDecoder
}()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
}
