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
    //без изменения полей
    fileprivate lazy var mainRealm = try! Realm(configuration: .defaultConfiguration)

//удалить все
    func clearAll(){
        try! mainRealm.write({
            mainRealm.deleteAll()
        })
    }
//сохранить родителя
    func saveParent(parent: ParentModel) {
        try! mainRealm.write({
            mainRealm.add(parent)
        })
    }
//сохранить ребенка
    func saveChild(child: ChildModel){
        try! mainRealm.write({
            mainRealm.add(child)
        })
    }
//удалить
    func removeObject(object: Object){
        try! mainRealm.write({
            mainRealm.delete(object)
        })
    }
//достать родителя
    func obtainParent() -> [ParentModel]{
        let models = mainRealm.objects(ParentModel.self)
        
        return Array(models)
    }
//достать ребенка
    func obtainChild() -> [ChildModel]{
        let models = mainRealm.objects(ChildModel.self)
        
        return Array(models)
    }
}

