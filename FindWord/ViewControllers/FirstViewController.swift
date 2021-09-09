//
//  FirstViewController.swift
//  FindWord
//
//  Created by Serega Kushnarev on 17.12.2020.
//

import UIKit

// MARK: - FirstViewController

class FirstViewController: UIViewController, UITableViewDelegate {
    
    //MARK: - private properties
    
    private let tableView = UITableView()
    private let identifire = "myTableViewCell"
    private var wordArray: [Word] = []
    private var textField = UITextField()
    private let networkService = NetworkService()
   
    // MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - view
        
        setUpView()
    }

    // MARK: - Private methods
    
    private func setUpView() {
        setUpTableView()
        setUpTextField()
        
        createTextField()
        createTableView()
    }
    
    private func setUpTextField() {
        textField.font = .systemFont(ofSize: 20)
        textField.placeholder = "write text"
        textField.textAlignment = .center
        textField.delegate = self
        view.addSubview(textField)
    }
    
    
    
    private func setUpTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: identifire)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func getWord() {
        networkService.getWord(text: textField.text ?? "") { result in
            switch result {
            case .success(let word):
                if let word = word {
                    DispatchQueue.main.async {
                        self.wordArray = word
                        self.tableView.reloadData()
                    }
                }
            case .failure(_):
                self.showAlert(message: "Проверьте соединение")
                
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension FirstViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        getWord()
        
        return true
    }
}

// MARK: - UITableViewDataSource

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? TableViewCell  {
            
            let word = wordArray[indexPath.row]
            
            cell.textLabel?.text = word.text
            
            return cell
        }
        return UITableViewCell()
    }
}
// MARK: - Layout

private extension FirstViewController {
    private func createTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    private func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}
