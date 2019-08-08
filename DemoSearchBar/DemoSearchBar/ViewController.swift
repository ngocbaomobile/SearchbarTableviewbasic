//
//  ViewController.swift
//  DemoSearchBar
//
//  Created by Ngoc on 8/8/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var animalArray = [Animal]()
    
    var currentAnimalArray = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupArrayAnimal()
        setupSearchBar()
        searchBarLayout()
    }
    
    private func setupArrayAnimal(){
        
        animalArray.append(Animal(name: "Bob", category: .cat, image: "1"))
        animalArray.append(Animal(name: "Milu", category: .cat, image: "2"))
        animalArray.append(Animal(name: "Poppy", category: .cat, image: "3"))
        animalArray.append(Animal(name: "Lay", category: .cat, image: "4"))
        
        animalArray.append(Animal(name: "Husky", category: .dog, image: "5"))
        animalArray.append(Animal(name: "Ngao", category: .dog, image: "6"))
        animalArray.append(Animal(name: "Cho", category: .dog, image: "7"))
        animalArray.append(Animal(name: "Abid", category: .dog, image: "8"))
        currentAnimalArray = animalArray
    }
    
    private func setupSearchBar(){
        searchBar.delegate = self
    }
    
    private func searchBarLayout(){
        tableView.tableHeaderView = UIView()
//        tableView.estimatedSectionHeaderHeight = 50
     //  navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchBar.showsScopeBar = false
    }
    
    // MARK: - Tablview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentAnimalArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return searchBar
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else {
            return UITableViewCell()
        }
        let animalIndex = currentAnimalArray[indexPath.row]
        cell.imgView.image = UIImage(named: animalIndex.image)
        cell.namelbl.text = animalIndex.name
        cell.categorylbl.text = animalIndex.category.rawValue
        return cell
    }
    
    
    // MARK: - Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  
        currentAnimalArray = animalArray.filter({ animal -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText != "" {
                    return animal.name.lowercased().contains(searchText.lowercased())
                } else {
                    return true
                }
            case 1:
                if searchText.isEmpty {
                    return animal.category == .dog
                } else {
                    return animal.name.lowercased().contains(searchText.lowercased()) && animal.category == .dog
                }
            case 2:
                if searchText.isEmpty {
                    return animal.category == .cat
                } else {
                    return animal.name.lowercased().contains(searchText.lowercased()) && animal.category == .cat
                }
            default:
                return false
            }
        })
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0:
            currentAnimalArray = animalArray
        case 1:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.dog
            })
        case 2:
            currentAnimalArray = animalArray.filter({ animal -> Bool in
                animal.category == AnimalType.cat
            })
        default:
            break
        }
        tableView.reloadData()
    }
    
    
}


class Animal {
    let name: String
    let image: String
    let category: AnimalType
    
    init(name: String, category: AnimalType, image: String) {
        self.name = name
        self.image = image
        self.category = category
    }
}


enum AnimalType: String {
    case cat = "Cat"
    case dog = "Dog"
}
