//
//  AllListViewController.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 12/10/21.
//

import UIKit

class AllListViewController: UIViewController {
    
    @IBOutlet weak var inspiringTable: UITableView!
    
    var inspiringWomenData = InspiringWomenData.data
    var indeks = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inspiringTable.delegate = self
        inspiringTable.dataSource = self
        
        inspiringTable.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "womenData")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationItem.title = "Inspiring Women"
    }
    
    @IBAction func doUnwind(segue: UIStoryboardSegue) {}
    
    
}

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inspiringWomenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "womenData") as! WomanTableViewCell
        cell.nameLabel.text = inspiringWomenData[indexPath.row].profileName
        cell.shortDescLabel.text = inspiringWomenData[indexPath.row].shortDescription
        cell.imagePreview.image = UIImage(named: inspiringWomenData[indexPath.row].imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indeks = indexPath.row
        performSegue(withIdentifier: "moveToDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            guard let destination = segue.destination as? DetailWomenViewController else { return }
            destination.indeks = indeks
        }
    }
    
}
