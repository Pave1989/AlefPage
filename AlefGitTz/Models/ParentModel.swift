//
//  ParentModel.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import RealmSwift
import Foundation

@objcMembers
class ParentModel: Object {
    dynamic var parentID = UUID()
    dynamic var surname = ""
    dynamic var name = ""
    dynamic var patronymic = ""
    dynamic var age = ""
    var childs = List<ChildModel>()
    
    override static func primaryKey() -> String? {
        return "parentID"
    }
}
