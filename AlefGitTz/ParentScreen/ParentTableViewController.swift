//
//  ParentTableViewController.swift
//  AlefGitTz
//
//  Created by Павел Галкин on 12.12.2022.
//

import UIKit
import RealmSwift

class ParentTableViewController: UITableViewController {
    
    private let headerSectionHeight: CGFloat = 310
    private let cellSectionHeight: CGFloat = 95
    private let footerSectionHeight: CGFloat = 70
    
    private let cellView = ChildCellView()
    private let headerView = HeaderCellView()
    private let footerView = FooterCellView()
    
    let realmManager: RealmManagerProtocol = RealmManager()
    var childsArray: Results<ChildModel>!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print array with BD parents
            let parents = realmManager.obtainParent()
            print("\(parents)")
            print("массив родителя")
        //print array with BD childs
            let childArray = realmManager.obtainChild()
            print("\(childArray)")
            print("массив детей")
        
        let realm = try! Realm()
        self.childsArray = realm.objects(ChildModel.self)
        self.tableView?.register(HeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: HeaderTableViewCell.reuseIdentifierHeader)
        tableView.register(FooterTableViewCell.self, forHeaderFooterViewReuseIdentifier: FooterTableViewCell.reuseIdentifierFooter)
        self.tableView?.register(ChildTableViewCell.self, forCellReuseIdentifier: ChildTableViewCell.reuseIdentifierCell)
        tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.separatorStyle = .none
    }
    
//MARK: - HEADER
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
             let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableViewCell.reuseIdentifierHeader) as! HeaderTableViewCell
            
        //creating parent model if array is empty
            let parentsArray = realmManager.obtainParent()
            if parentsArray.isEmpty == true {
                let parent = ParentModel()
                realmManager.saveParent(parent: parent)
                header.cellView.parentSurnameField.text = ""
                header.cellView.parentNameField.text = ""
                header.cellView.parentPatronymicField.text = ""
                header.cellView.parentAgeField.text = ""
                header.cellView.childButton.isEnabled = false
                header.cellView.parentLabel.text = "Заполните ваши данные"
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
            header.cellView.childButton.isHidden = childsArray.count == 5
            
            return header
        }
    //cell height header
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return headerSectionHeight
        }
    
//MARK: - CELL Child
    //number of children in the array
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return childsArray.count
            }
    
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: ChildTableViewCell.reuseIdentifierCell, for: indexPath) as! ChildTableViewCell
        //assigning text field values
                let childs = realmManager.obtainChild()
                cell.cellView.childNameField.text = childs[indexPath.row].name
                cell.cellView.childAgeField.text = childs[indexPath.row].age
        //delete by cell index
                cell.didDelete = { [weak self] in
                    guard let self = self else {return}
                    let child = self.childsArray[indexPath.row]
                    self.realmManager.removeObject(object: child)
//                    self.tableView.deleteRows(at: [indexPath], with: .right)
                        self.tableView.reloadData()
                    }
                return cell
            }
    //cell height child
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return cellSectionHeight
        }
    
//MARK: - FOOTER
        override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
             let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterTableViewCell.reuseIdentifierFooter) as! FooterTableViewCell

            footer.cellView.cancelButton.addTarget(self, action: #selector(deleteInfo), for: .touchUpInside)
           
            return footer
        }
    //cell height footer
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return footerSectionHeight
        }
    //alert function
        @objc func deleteInfo(){
            let alert = UIAlertController(title: "Очистить профиль?", message: "", preferredStyle: .alert)
            let parentDelete = UIAlertAction(title: "Удалить данные", style: .destructive){(alert) in
                self.realmManager.clearAll()
                self.tableView.reloadData()
                let parents = self.realmManager.obtainParent()
                print("\(parents)")
                print("Data deleted")
            }
            view.endEditing(true)
            alert.addAction(parentDelete)
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: .none))
            self.present(alert, animated: true, completion: nil)
        }
    }


