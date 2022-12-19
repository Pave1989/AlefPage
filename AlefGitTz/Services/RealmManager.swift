//
//  RealmManager.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func clearAll()
    func saveChild(child: ChildModel)
    func saveParent(parent: ParentModel)
    func removeObject(object: Object)
    func obtainChild() -> [ChildModel]
    func obtainParent() -> [ParentModel]

}
class RealmManager: RealmManagerProtocol {
//without changing fields
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)

//delete everything
    func clearAll(){
        try! mainRealm.write({
            mainRealm.deleteAll()
        })
    }
//save parent
    func saveParent(parent: ParentModel) {
        try! mainRealm.write({
            mainRealm.add(parent)
        })
    }
//save child
    func saveChild(child: ChildModel){
        try! mainRealm.write({
            mainRealm.add(child)
        })
    }
//delete
    func removeObject(object: Object){
        try! mainRealm.write({
            mainRealm.delete(object)
        })
    }
//get a parent
    func obtainParent() -> [ParentModel]{
        let models = mainRealm.objects(ParentModel.self)
        
        return Array(models)
    }
//get a child
    func obtainChild() -> [ChildModel]{
        let models = mainRealm.objects(ChildModel.self)
        
        return Array(models)
    }
}

