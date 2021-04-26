//
//  ToDoViewController.swift
//  DataBaseHomeWork
//
//  Created by Vlad Zaborsky on 23.04.2021.
//

// WHAT TO DO:
//

import UIKit

class ToDoViewController: UIViewController {
    
    let arrayData = realm.objects(Task.self)

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    
    }
    
// MARK: - Add Button Tapped & Send task object to Realm
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Добавить задание", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        let action = UIAlertAction(title: "Добавить", style: .default) { (_) in
            guard let inputTask = alert.textFields?.first?.text else { return }
            let task = Task()
            task.item = inputTask
            StorageManager.saveTask(task)
            DispatchQueue.main.async { 
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(action)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "To Do App"
    }

}

// MARK: - TableView Delegate

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = arrayData[indexPath.row]
        
        let alert = UIAlertController(title: "Удалить ячейку?", message: "Восстановить будет невозможно", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteButton = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
            StorageManager.deleteTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
        
    }
}

// MARK: - Table View Data Source

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayData.isEmpty ? 0 : arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        let task = self.arrayData[indexPath.row]
        cell.textLabel?.text = task.item
        
        return cell
    }
    
}
