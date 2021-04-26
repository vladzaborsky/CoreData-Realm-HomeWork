//
//  WeatherViewController.swift
//  DataBaseHomeWork
//
//  Created by Влад Заборский on 25.04.2021.
//

import UIKit
import RealmSwift

// TODO: - 1. Модель данных Swift Codable — Done
//         2. Модель данных Realm — Done
//         3. Функцию, которая мэтчит данные между Codable & RealmObject


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTemp: UILabel!
    
    private let path = URLPath()
    private let getData = NetworkManager()
    
    let arrayData2 = realm.objects(DataSet.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        print(arrayData2)
//        clearRealm()
    }
    
    func updateUI() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Weather App"
        
        let lastAddedObject = arrayData2.first
        if let currentTempData = lastAddedObject?.temp {
            self.currentTemp.text = "\(Int(currentTempData - 273.15)) °C"
        }
        
    }
    
    func clearRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }
// MARK: - Пытаюсь преобразовать полученные данные в DataSet с помощью функции
    
    func generateData(_ object: Response) {
        
        for item in object.daily {
            let dataSet = DataSet()
            dataSet.temp = object.current.temp
            dataSet.day = item.temp.day
            print(item.temp.day)
            
            try! realm.write {
                realm.add(dataSet)
            }
//            let dailyItem = Daily()
//            dailyItem.day = item.temp.day
//            dataSet.daily.append(dailyItem)
            
        }
        
    }

    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let url = path.urlPath
        
        getData.getData(url) { (data) in
            DispatchQueue.main.async {
                self.generateData(data)
                self.currentTemp.text = data.current.dayTemperature
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        clearRealm()
        self.currentTemp.text = "No data"
        self.tableView.reloadData()
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        var numbersOfRows = 0
//
//        for item in arrayData2 {
//            numbersOfRows = item.daily.count
//        }
        
        return arrayData2.isEmpty ? 0 : arrayData2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        let object = arrayData2[indexPath.row]

        cell.textLabel?.text = "\(Int(object.day - 273.15)) °C"
        
        return cell
    }
    
    
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
