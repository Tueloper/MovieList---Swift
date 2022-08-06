//
//  ViewController.swift
//  Movielist
//
//  Created by Tueloper on 05/08/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    var movies = [
        "Eternals", "Dune", "No Time To Die", "Last Night in Soho", "Ron’s Done Wrong", "Halloween Kills","Venom","Antlers","The Addams Family 2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movies = UserDefaults.standard.stringArray(forKey: "movies") ?? []
        
        title = "Movielist"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Movie", message: "Please enter a new Movie", preferredStyle: .alert)
        
        alert.addTextField { field in field.placeholder = "Enter movie..." }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    print(text)
                    
                    DispatchQueue.main.async {
                        var currentMovies = UserDefaults.standard.stringArray(forKey: "movies") ?? []
                        
                        currentMovies.append(text)
                        
                        UserDefaults.standard.setValue(currentMovies, forKey: "movies")
                        self.movies.append(text)
                        self.table.reloadData()
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row]
        
        return cell;
    }

}


