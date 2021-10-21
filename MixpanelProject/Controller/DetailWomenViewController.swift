//
//  DetailWomenViewController.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 12/10/21.
//

import UIKit

class DetailWomenViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var profilName: UILabel!
    @IBOutlet weak var shortDesc: UILabel!
    @IBOutlet weak var briefHistoryText: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var inspiringWomenData = InspiringWomenData.data
    var indeks = 0
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePreview.image = UIImage(named: inspiringWomenData[indeks].imageName)
        profilName.text = inspiringWomenData[indeks].profileName
        shortDesc.text = inspiringWomenData[indeks].shortDescription
        self.navigationItem.title = "Profil"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @IBAction func changeFavorite(_ sender: UIButton) {
        isFavorite = !isFavorite
        inspiringWomenData[indeks].isFavorite = isFavorite
        
        if isFavorite {
            favoriteButton.setTitle("Favourited", for: .normal)
            
        } else if !isFavorite {
            favoriteButton.setTitle("Add to Favourite", for: .normal)
        }
        
    }
    @IBAction func buyBiography(_ sender: UIButton) {
        performSegue(withIdentifier: "buyBiography", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BuyBiographyViewController else { return }
        destination.womanDataIndeks = indeks
    }
    
}
