//
//  PaymentViewController.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 13/10/21.
//

import UIKit

protocol PaymentMethodTableViewCellDelegate: AnyObject {
    func toggleSomeValue(for cell: PaymentMethodTableViewCell)
    func unCheckButton(for cell: PaymentMethodTableViewCell)
}

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var paymentSummaryTable: UITableView!
    
    var bookOrder = [BookData]()
    var bookIndeks = 0
    let methods = ["Gopay", "OVO", "DANA"]
    var choosenMethod = ""
    
    var shippingPrice = 15000
    
    var cell = PaymentMethodTableViewCell()
    var orderCell = OrderTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentSummaryTable.delegate = self
        paymentSummaryTable.dataSource = self
        paymentSummaryTable.register(UINib(nibName: "ShippingTableViewCell", bundle: nil), forCellReuseIdentifier: "shippingCell")
        paymentSummaryTable.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        paymentSummaryTable.register(UINib(nibName: "PaymentMethodTableViewCell", bundle: nil), forCellReuseIdentifier: "methodCell")
        paymentSummaryTable.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        self.navigationItem.title = "Payment"
    }
    
    @IBAction func payNow(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Payment Succeed", message: "Your order is confirmed", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            self.performSegue(withIdentifier: "doUnwind", sender: self)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setUpPriceView() {
        self.orderCell.priceBookTotal.text = "Rp " + "\(calculateBookPrice())"
        self.orderCell.priceTotal.text = "Rp " +  "\(calculateTotalPrice())"
    }
    
    func calculateBookPrice() -> Int {
        var bookPriceByQuantity = 0
        
        for bookIndeks in 0 ..< bookOrder.count {
            bookPriceByQuantity += (bookOrder[bookIndeks].bookQuantity * bookOrder[bookIndeks].bookPrice)
        }
        return bookPriceByQuantity
    }
    
    func calculateTotalPrice() -> Int {
        return (calculateBookPrice() + shippingPrice)
    }
}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = ""
        
        switch section {
        case 0:
            sectionTitle = "Shipping Details"
        case 1:
            sectionTitle = "Order Details"
        case 2:
            sectionTitle = "Price Details"
        case 3:
            sectionTitle = "Payment Methods (choose one)"
        default:
            break
        }
        
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        
        switch section {
        case 0:
            rowNumber = 1
        case 1:
            rowNumber = bookOrder.count
        case 2:
            rowNumber = 1
        case 3:
            rowNumber = 3
        default:
            break
        }
        
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "shippingCell") as! ShippingTableViewCell
        case 1:
            let bookCell = tableView.dequeueReusableCell(withIdentifier: "bookCell") as! BookTableViewCell
            bookCell.isChecked = bookOrder[indexPath.row].isChecked
            bookCell.bookStepper.value = Double(bookOrder[indexPath.row].bookQuantity)
            bookCell.bookQuantity.text = "\(bookOrder[indexPath.row].bookQuantity)"
            bookCell.bookImageCover.image = bookOrder[indexPath.row].bookImageCover
            bookCell.bookTitle.text = bookOrder[indexPath.row].bookTitle
            bookCell.bookPrice.text = "\(bookOrder[indexPath.row].bookPrice)"
            bookCell.setUpView()
            bookCell.delegate = self
            cell = bookCell
        case 2:
            let orderCell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! OrderTableViewCell
            orderCell.priceBookTotal.text = "Rp " + "\(calculateBookPrice())"
            orderCell.shippingPrice.text = "Rp " + "\(shippingPrice)"
            orderCell.priceTotal.text = "Rp " +  "\(calculateTotalPrice())"
            self.orderCell = orderCell
            cell = orderCell
        case 3:
            let methodCell = tableView.dequeueReusableCell(withIdentifier: "methodCell") as! PaymentMethodTableViewCell
            methodCell.methodName.text = methods[indexPath.row]
            methodCell.delegate = self
            cell = methodCell
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        switch indexPath.section {
        case 0 :
            height = 266
        case 1, 2:
            height = 146
        case 3:
            height = 50
        default:
            break
        }
        return height
    }
    
}

extension PaymentViewController: PaymentMethodTableViewCellDelegate, BookTableViewCellDelegate {
    
    func addBookOrder(for cell: BookTableViewCell) {
        guard let indexPath = paymentSummaryTable.indexPath(for: cell) else { return }
        bookIndeks = indexPath.row
        let isChecked = bookOrder[bookIndeks].isChecked
        if isChecked {
            bookOrder[bookIndeks].bookQuantity = cell.quantity
            setUpPriceView()
        }
    }
    
    func controlSomeValue(for cell: BookTableViewCell) {
        guard let indexPath = paymentSummaryTable.indexPath(for: cell) else { return }
        bookIndeks = indexPath.row
        bookOrder[bookIndeks].bookQuantity = cell.quantity
        setUpPriceView()
    }
    
    func unCheckButton(for cell: PaymentMethodTableViewCell) {
        if let choosenButton = self.cell.choosenButton {
            choosenButton.setImage(UIImage(systemName: "square"), for: .normal)
            self.cell.isChoosen = false
        }
    }
    
    func toggleSomeValue(for cell: PaymentMethodTableViewCell) {
        guard let indexPath = paymentSummaryTable.indexPath(for: cell) else { return }
        choosenMethod = methods[indexPath.row]
        self.cell = cell
    }
    
}
