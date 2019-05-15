//
//  Card.swift
//  ShopifyInternMobileApp
//
//  Created by Kelley Zhang on 5/12/19.
//  Copyright © 2019 Kelley Zhang. All rights reserved.
//
import UIKit
import Foundation

class Card {
    var value = "-"
    var displayValue = "-"
    var isFlipped = false
    var isOccupied = false
    var isHighlighted = false
    var color :UIColor = .black
    
    func setValue(str: String){
        value = str
        displayValue = str
    }
}
