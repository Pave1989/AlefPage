//
//  ParentTableViewController.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import RealmSwift

class ParentTableViewController: UITableViewController {

    let realmManager: RealmManagerProtocol = RealmManager()
    var childsArray: Results<ChildModel>!
    let cellID = "reuseIdentifier"
    let headerID = "reuseIdentierHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //print array with BD parents
            let parents = realmManager.obtainParent()
            print("\(parents)")
            print("массив родителя")
//        //print array with BD childs
//            let childArray = dbManager.obtainChild()
//            print("\(childArray)")
//            print("массив детей")
        
        let realm = try! Realm()
        self.childsArray = realm.objects(ChildModel.self)
        self.tableView?.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableViewCell.reuseIdentifierHeader)
        tableView.register(FooterTableViewCell.self, forHeaderFooterViewReuseIdentifier: FooterTableViewCell.reuseIdentifierFooter)
        self.tableView?.register(ChildTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.separatorStyle = .none
    }
    
//HEADER
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableViewCell.reuseIdentifierHeader) as! HeaderTableViewCell

            let parentsArray = realmManager.obtainParent()
        //creating parent model if array is empty
            if parentsArray.isEmpty == true {
                header.cellView.parentSurnameField.text = ""
                header.cellView.parentNameField.text = ""
                header.cellView.parentPatronymicField.text = ""
                header.cellView.parentAgeField.text = ""
                tableView.reloadData()
                let parent = ParentModel()
                realmManager.saveParent(parent: parent)
            } else {
                let indexParent = parentsArray.endIndex - 1
                header.cellView.parentSurnameField.text = parentsArray[indexParent].surname
                header.cellView.parentNameField.text = parentsArray[indexParent].name
                header.cellView.parentPatronymicField.text = parentsArray[indexParent].patronymic
                header.cellView.parentAgeField.text = parentsArray[indexParent].age
                }
            //reload tableView
                header.tableViewReload = { [weak self] in
                    guard let self = self else {return}
                    self.tableView.reloadData()
            }
            //hiding a button
            if childsArray.count == 5{
                header.cellView.childButton.isHidden = true
            }else{
                header.cellView.childButton.isHidden = false
            }
            return header
        }
    //cell height header
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 310
        }
    
//CELL Child
    //number of children in the array
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return childsArray.count
            }
    
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChildTableViewCell
        //assigning text field values
                let childs = realmManager.obtainChild()
                cell.cellView.childNameField.text = childs[indexPath.row].name
                cell.cellView.childAgeField.text = "\(childs[indexPath.row].age)"
        //delete by cell index
                cell.didDelete = { [weak self] in
                    guard let self = self else {return}
                    let child = self.childsArray[indexPath.row]
                    self.realmManager.removeObject(object: child)
        //self.tableView.deleteRows(at: [indexPath], with: .right)
                        self.tableView.reloadData()
                    }
                return cell
            }
    //cell height child
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 95
        }
    
//FOOTER
        override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
             let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterTableViewCell.reuseIdentifierFooter) as! FooterTableViewCell
            footer.cellView.cancelButton.addTarget(self, action: #selector(deleteInfo), for: .touchUpInside)
           
            return footer
        }
    //cell height footer
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 70
        }
    //alert function
        @objc func deleteInfo(){
            let alert = UIAlertController(title: "Очистить профиль?", message: "", preferredStyle: .alert)
            let parentDelete = UIAlertAction(title: "Удалить данные", style: .destructive){(alert) in
                self.realmManager.clearAll()
//MARK: - не очищаются строки если не добавлен ребенок родителю
                self.tableView.reloadData()
                let parents = self.realmManager.obtainParent()
                print("\(parents)")
                print("Данные удалены")
            }
            alert.addAction(parentDelete)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: .none))
            self.present(alert, animated: true, completion: nil)
        }
}

