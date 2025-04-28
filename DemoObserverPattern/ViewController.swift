//
//  ViewController.swift
//  DemoObserverPattern
//
//  Created by Alok Kumar on 28/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var obsersers: [Observer] = []
    private var observerId: Int = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "ObserverCell", bundle: nil), forCellReuseIdentifier: "ObserverCell")
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    @IBAction func didTapOnAdd(_ sender: UIButton) {
        let concreteObserver = ConcreteObserver(id: observerId, message: "Observer \(observerId) created")
        obsersers.append(concreteObserver)
        observerId += 1
        reloadTableView()
    }
    
    @IBAction func didTapOnNotify(_ sender: UIButton) {
        showAlert()
        //let alert = uialertcon
//        obsersers.forEach { observer in
//            observer.update(data: "New movie out!")
//        }
//        reloadTableView()
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Notify Observers", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Enter observer id separated by comma to notify them"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Enter Notification Message"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self] _ in
            if let self = self, let ids = alert.textFields?[0].text, let message = alert.textFields?[1].text {
                if ids.isEmpty {
                    self.obsersers.forEach { observer in
                        observer.update(data: message)
                    }
                } else {
                    let idArr = (ids.components(separatedBy: ",")).compactMap { id in
                        Int(id)
                    }
                    print(idArr)
                    (self.obsersers.filter { idArr.contains($0.id) }).forEach { observer in
                        observer.update(data: message)
                    }
                }
                self.reloadTableView()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        obsersers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ObserverCell", for: indexPath) as? ObserverCell, let observer = obsersers[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(observer: observer)
        
        return cell
    }
}

final class ConcreteObserver: Observer {
    var id: Int
    var message: String?
    
    init(id: Int, message: String) {
        self.id = id
        self.message = message
    }
    
    func update(data: String) {
        self.message = "Observer \(id): \(data)"
    }
}
