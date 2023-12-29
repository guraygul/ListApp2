//
//  TaskViewController.swift
//  ListApp2
//
//  Created by Güray Gül on 26.12.2023.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var task: String?
    var updateFromDelete: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask() {
        let defaults = UserDefaults()
        var tasks = defaults.value(forKey: "tasks") as? [String] ?? [String]()
        tasks.remove(at: tasks.firstIndex(of: task!)!)
        defaults.setValue(tasks, forKey: "tasks")
        updateFromDelete?()
        navigationController?.popViewController(animated: true)
    }
    
}
