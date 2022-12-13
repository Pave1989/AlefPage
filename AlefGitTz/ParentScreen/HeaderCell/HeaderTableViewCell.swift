//
//  HeaderTableViewCell.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import SnapKit
import RealmSwift

class HeaderTableViewCell: UITableViewHeaderFooterView, UITextFieldDelegate {
    
    let dbManager: RealmManagerProtocol = RealmManager()
    var childs: Results<ChildModel>!
    //complition handler
    var tableViewReload: () -> () = {}
    static let reuseIdentifierHeader: String = String(describing: HeaderTableViewCell.self)
    
    private(set) var cellView = HeaderCellView()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        initializeUI()
        createConstraints()
        self.cellView.fieldParentSurname.delegate = self
        self.cellView.fieldParentName.delegate = self
        self.cellView.fieldParentPatronymic.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initializeUI(){
        //чтобы работали textField добавить подвид в contentMode
        contentView.addSubview(cellView)

        cellView.fieldParentSurname.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.fieldParentName.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.fieldParentPatronymic.addTarget(self, action: #selector(saveParentRealm), for: .editingChanged)
        cellView.fieldParentAge.addTarget(self, action: #selector(self.saveParentRealm), for: .editingChanged)
        //функция добавления ребенка на экран
        cellView.buttonChild.addTarget(self, action: #selector(addNewChild), for: .touchUpInside)
        cellView.fieldParentAge.addTarget(self, action: #selector(self.textFieldFilter), for: .editingChanged)
    }
    
    private func createConstraints(){
        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().inset(0)
            make.right.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    //функия делегата для ввода данных только буквами
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let letters = CharacterSet(charactersIn: "абвгдежзийклмнопрстуфхцчшщъыьэюяАБВГДЕЖЗИКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ").inverted
       return (string.rangeOfCharacter(from: letters) == nil)
    }

    //функция добавления ребенка
        @objc func addNewChild(){

            let parents = dbManager.obtainParent()
            let indexParent = parents.endIndex - 1
            let parent = ParentModel()
            let child = ChildModel()
            let realm = try! Realm()
            try! realm.write {
                parent.parentID = parents[indexParent].parentID
                parent.surname = parents[indexParent].surname
                parent.name = parents[indexParent].name
                parent.patronymic = parents[indexParent].patronymic
                parent.age = parents[indexParent].age
                parent.childs = parents[indexParent].childs
                parent.childs.append(child)
                realm.add(parent, update: .modified)
            }
            tableViewReload()
            
        //принт массива с родителями бд
                let parentsArray = dbManager.obtainParent()
                print("\(parentsArray)")
                print("добавился ребенок")
        }
    
//функция срабатывает 0 при вводе данных в поле + ограничение символов ввода
    @objc private func textFieldFilter(_ textField: UITextField) {
        
        if textField.text!.lengthOfBytes(using: String.Encoding.utf8) > 2 {
            textField.text = String(textField.text!.prefix(2))
        }
        if  let text = textField.text, let intText = Int(text) {
          textField.text = "\(intText)"
        } else {
          textField.text = ""
        }
    }
//функция сохраняет родительские данные в бд с каждым изменением поля TextField
    //В дальнейшем сохранение родителя должно происходить либо при помощи отдельной кнопки либо тапом на следующий экран.Но в ТЗ нужно сделать пока так
    @objc private func saveParentRealm(_ textField: UITextField){

        let parents = dbManager.obtainParent()
        let oldParentID = parents.endIndex - 1
        let parent = ParentModel()
        let realm = try! Realm()
        try! realm.write({
            parent.parentID = parents[oldParentID].parentID
            parent.surname = cellView.fieldParentSurname.text ?? ""
            parent.name = cellView.fieldParentName.text ?? ""
            parent.patronymic = cellView.fieldParentPatronymic.text ?? ""
            parent.age = cellView.fieldParentAge.text ?? ""
            realm.add(parent, update: .modified)
        })
   
        //принт массива с родителями бд
        print("\(parents)")
    }
}
