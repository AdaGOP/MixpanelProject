//
//  InspiringWomenData.swift
//  MixpanelProject
//
//  Created by khoirunnisa' rizky noor fatimah on 12/10/21.
//

import Foundation
import UIKit

struct InspiringWomenData {
    var imageName: String
    var profileName: String
    var shortDescription: String
    var biographys: [BookData]
    var isFavorite: Bool
}

struct BookData {
    var bookImageCover: UIImage?
    var bookTitle: String
    var bookPrice: Int
    var bookQuantity: Int
    var isChecked: Bool
}

struct SummaryOrder {
    var bookOrders: [BookData]
    var paymentMethod: String
    
}

extension InspiringWomenData {
    static var data: [InspiringWomenData] {
        [
            InspiringWomenData(imageName: "Greta", profileName: "Greta Thunberg", shortDescription: "The 18-year-old climate activist who recently nominated for a Nobel Prize for a third year in a row.", biographys: [BookData(bookImageCover: UIImage(named: "GretaBook"), bookTitle: "No One is Too Small to Make Difference", bookPrice: 95000, bookQuantity: 0, isChecked: false)], isFavorite: false),
            InspiringWomenData(imageName: "Marie", profileName: "Marie Curie", shortDescription: "A Polish and naturalized-French physicist and chemist who conducted pioneering research on radioactivity.", biographys: [BookData(bookImageCover: UIImage(named: "MarieBook"), bookTitle: "A Life from Beginning to End", bookPrice: 125000, bookQuantity: 0, isChecked: false)], isFavorite: false),
            InspiringWomenData(imageName: "Helen", profileName: "Helen Keller", shortDescription: "An American author, disability rights advocate, political activist and lecturer.", biographys: [BookData(bookImageCover: UIImage(named: "HelenBook"), bookTitle: "The Story of My Life", bookPrice: 130000, bookQuantity: 0, isChecked: false)], isFavorite: false),
            InspiringWomenData(imageName: "Malala", profileName: "Malala Yousafzai", shortDescription: "A Pakistani activist for female education and a Nobel Peace Prize laureate.", biographys: [BookData(bookImageCover: UIImage(named: "MalalaBook"), bookTitle: "The Girl Who Stood Up for Education and Was Shot by Taliban", bookPrice: 140000, bookQuantity: 0, isChecked: false)], isFavorite: false),
            InspiringWomenData(imageName: "Katherine", profileName: "Katherine Johnson", shortDescription: "An American mathematician whose calculations of orbital mechanics as a NASA employee were critical to the success of the first and subsequent U.S. crewed spaceflights.", biographys: [BookData(bookImageCover: UIImage(named: "KatherineBook"), bookTitle: "Reaching for The Moon", bookPrice: 90000, bookQuantity: 0, isChecked: false)], isFavorite: false)
        ]
    }
}
