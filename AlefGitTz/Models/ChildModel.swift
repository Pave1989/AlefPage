//
//  ChildModel.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import RealmSwift
import Foundation

@objcMembers
class ChildModel: Object {
    dynamic var childID = UUID()
    dynamic var name = ""
    dynamic var age = ""
    
    override static func primaryKey() -> String? {
        return "childID"
    }
}
