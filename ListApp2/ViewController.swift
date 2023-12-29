//
//  ViewController.swift
//  ListApp2
//
//  Created by Güray Gül on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tasks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"

        tableView.delegate = self
        tableView.dataSource = self
        
        let defaults = UserDefaults()
        
        if !defaults.bool(forKey: "setup") {
            defaults.set(true, forKey: "setup")
            defaults.set([], forKey: "count")
        }
        updateTasks()
    }
    
    func updateTasks() {
        
        tasks.removeAll()
        let taskFromDefault = UserDefaults().value(forKey: "tasks") as? [String] ?? [String]()
        tasks = taskFromDefault
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        vc.updateFromDelete = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
