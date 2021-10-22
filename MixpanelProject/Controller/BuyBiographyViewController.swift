//
//  BuyBiographyViewController.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 12/10/21.
//

import UIKit
import Mixpanel

protocol BookTableViewCellDelegate: AnyObject {
    func controlSomeValue(for cell: BookTableViewCell)
    func addBookOrder(for cell: BookTableViewCell)
}

class BuyBiographyViewController: UIViewController {
    
    var inspiringData = InspiringWomenData.data
    var womanDataIndeks = 0
    var bookIndeks = 0
    
    var bookOrder = [BookData]()
    
    @IBOutlet weak var bookTable: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Keranjang"
        checkoutButton.isEnabled = false
        bookTable.delegate = self
        bookTable.dataSource = self
        bookTable.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
    }
    
    @IBAction func checkoutNow(_ sender: UIButton) {
        Mixpanel.mainInstance().track(event: "checkout_book", properties: ["profile_name": inspiringData[womanDataIndeks].profileName, "platform": "iOS"])
        for bookIndeks in 0 ..< bookOrder.count {
            Mixpanel.mainInstance().track(event: "checkout_book", properties: ["ordered_book_name": bookOrder[bookIndeks].bookTitle, "number_of_book": bookOrder[bookIndeks].bookQuantity])
        }
        if bookOrder.count != 0 {
            performSegue(withIdentifier: "payNow", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "payNow" {
            guard let destination = segue.destination as? PaymentViewController else { return }
            destination.bookOrder = bookOrder
        }
        
    }
    
}

extension BuyBiographyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inspiringData[womanDataIndeks].biographys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookTableViewCell
        cell.bookImageCover.image = inspiringData[womanDataIndeks].biographys[indexPath.row].bookImageCover
        cell.bookTitle.text = inspiringData[womanDataIndeks].biographys[indexPath.row].bookTitle
        cell.bookPrice.text = "\(inspiringData[womanDataIndeks].biographys[indexPath.row].bookPrice)"
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
}

extension BuyBiographyViewController: BookTableViewCellDelegate {
    func addBookOrder(for cell: BookTableViewCell) {
        guard let indexPath = bookTable.indexPath(for: cell) else { return }
        bookIndeks = indexPath.row
        
        inspiringData[womanDataIndeks].biographys[bookIndeks].bookQuantity = cell.quantity
        
        inspiringData[womanDataIndeks].biographys[bookIndeks].isChecked = cell.isChecked
        
        let isChecked = inspiringData[womanDataIndeks].biographys[bookIndeks].isChecked
        
        if isChecked {
            bookOrder.append(inspiringData[womanDataIndeks].biographys[bookIndeks])
        } else if !isChecked {
            bookOrder.remove(at: bookIndeks)
        }
        
        if bookOrder.count != 0 {
            checkoutButton.isEnabled = true
        } else if bookOrder.count == 0  {
            checkoutButton.isEnabled = false
        }
    }
    
    
    func controlSomeValue(for cell: BookTableViewCell) {
        guard let indexPath = bookTable.indexPath(for: cell) else { return }
        bookIndeks = indexPath.row
        
        inspiringData[womanDataIndeks].biographys[bookIndeks].isChecked = cell.isChecked
        
        let isChecked = inspiringData[womanDataIndeks].biographys[bookIndeks].isChecked
        
        if isChecked {
            bookOrder[bookIndeks].bookQuantity = cell.quantity
        }
        
    }
}
