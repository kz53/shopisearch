//
//  CardCollectionViewCell.swift
//  appFour
//
//  Created by Kelley Zhang on 5/12/19.
//  Copyright © 2019 Kelley Zhang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var labelView: UILabel!
    var card:Card?
    
    func setCard(_ card:Card){
        self.card = card
        labelView.text = card.displayValue
    }
    
    func updateLabel(){
        labelView.text = card?.displayValue
        if (card?.isHighlighted)! {
            labelView.textColor = getRandomColor()
        }
        else{
            labelView.textColor = .black
        }
        
        
    }
    
    func flip() {
        card?.color = getRandomColor()
        labelView.textColor = card?.color
    }
    
    func flipBack() {
        labelView.textColor = .black
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
