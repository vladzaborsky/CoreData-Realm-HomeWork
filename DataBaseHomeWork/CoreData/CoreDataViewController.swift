//
//  CoreDataViewController.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 25.04.2021.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayOfTasksCoreData: [CoreDataTask] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<CoreDataTask> = CoreDataTask.fetchRequest()
        
        do {
            arrayOfTasksCoreData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
// MARK: - Add Button Tapped
    
    @IBAction func addCoreDataButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        alertController.addTextField { (_) in }
        
        let cancelBtn = UIAlertAction(title: "Отменить", style: .cancel)
        let addBtn = UIAlertAction(title: "Добавить", style: .default) { (_) in
            guard let inputTask = alertController.textFields?.first?.text else { return }
            self.saveData(inputTask)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(cancelBtn)
        alertController.addAction(addBtn)
        
        present(alertController, animated: true)
    }
    
// MARK: - UpdateUI
    
    func updateUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "CoreData ToDo App"
    }
    
// MARK: — Get viewContext
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
// MARK: - Func save data
    
    func saveData(_ task: String) {
         
        let context = getContext()
        
        guard let taskEntity = NSEntityDescription.entity(forEntityName: "CoreDataTask", in: context) else { return }
        
        let taskObject = CoreDataTask(entity: taskEntity, insertInto: context)
        taskObject.task = task
        
        do {
            try context.save()
            arrayOfTasksCoreData.insert(taskObject, at: 0)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Table View Delegate

extension CoreDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRow = arrayOfTasksCoreData[indexPath.row]
        
        let context = getContext()
        context.delete(selectedRow)
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }

/// У меня крашилось приложение, когда я вызывал tableView.deleteRows(at: [indexPath], with: .automatic) — почему?
/// В Реалме все работало,  а тут нет
        
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
}

// MARK: - Table View DataSource

extension CoreDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfTasksCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCoreData", for: indexPath)
        
        let task = arrayOfTasksCoreData[indexPath.row]
        cell.textLabel?.text = task.task
        
        return cell
    }
    
    
}
