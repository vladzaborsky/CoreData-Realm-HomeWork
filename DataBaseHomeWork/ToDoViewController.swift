//
//  ToDoViewController.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 23.04.2021.
//

// WHAT TO DO:
//

import UIKit

class ToDoViewController: UIViewController {
    
    var arrayData: Results<Task>!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        arrayData = realm.objects(Task.self)
        
        let item = Task()
        item.item = "Покурить"
        
        StorageManager.saveTask(item)
        
        let item2 = realm.objects(Task.self)
        print(item2)
        
    }
    
// MARK: - Add Button Tapped
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }

}

// MARK: - TableView Delegate

extension ToDoViewController: UITableViewDelegate {
    
}

// MARK: - Table View Data Source

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return arrayData.isEmpty ? 0 : arrayData.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
//        let task = self.arrayData[indexPath.row]
//        cell.textLabel?.text = task.item
        
        return cell
    }
    
}
