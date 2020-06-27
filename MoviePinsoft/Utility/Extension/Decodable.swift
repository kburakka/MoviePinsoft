//
//  Decodable.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation

extension Decodable{
    func asDictionary() -> [String:Any]{
        var dict : [String:Any] {
          let mirror = Mirror(reflecting: self)
          let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            return (label, value)
          }).compactMap { $0 })
          return dict
        }
        return dict
    }
}
