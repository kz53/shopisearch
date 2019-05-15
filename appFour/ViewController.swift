//
//  ViewController.swift
//  appFour
//
//  Created by Kelley Zhang on 5/12/19.
//  Copyright © 2019 Kelley Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var label6: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    
    @IBAction func doneClick(_ sender: UIButton) {
        if (winCondition == false){
            winCondition = true

            revealAll()
            sender.setTitle("New Game?", for:.normal)
        }
        else{
            
            winCondition = false
            sender.setTitle("Done", for:.normal)
            selectionLabel.text = ""
            unRevealAll()
            model.getCards()
            cardMatrix = model.cardMatrix
            model.placeWord(word: "OBJECTIVEC")
            model.placeWord(word: "SWIFT")
            model.placeWord(word: "JAVA")
            model.placeWord(word: "MOBILE")
            model.placeWord(word: "KOTLIN")
            model.placeWord(word: "VARIABLE")
            label1.attributedText = nil
            label1.text = "OBJECTIVEC"
            label2.attributedText = nil
            label2.text = "KOTLIN"
            label3.attributedText = nil
            label3.text = "MOBILE"
            label4.attributedText = nil
            label4.text = "JAVA"
            label5.attributedText = nil
            label5.text = "SWIFT"
            label6.attributedText = nil
            label6.text = "VARIABLE"
            collectionView.reloadData()
            wordsFound = 0
            scoreLabel.text = "Found 0/6"
        }
        
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    // dificulty level
    var difficultyLevel = 1
    var currentSelection: [String] = []
    var currentSelectionCells: [IndexPath] = []
    var winCondition = false
    var submittedString = ""
    var wordsFound = 0
    var maxWordsFound = 6
    var model = CardModel()
    var cardArray = [Card]()
    var cardMatrix = [[Card]]()
    var cellArray = [CardCollectionViewCell]()
    var numRows = 10
    var numCols = 10

    var heldDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        model.getCards()
        model.placeWord(word: "OBJECTIVEC")
        model.placeWord(word: "SWIFT")
        model.placeWord(word: "JAVA")
        model.placeWord(word: "MOBILE")
        model.placeWord(word: "KOTLIN")
        model.placeWord(word: "VARIABLE")
        label1.text = "OBJECTIVEC"
        label2.text = "KOTLIN"
        label3.text = "MOBILE"
        label4.text = "JAVA"
        label5.text = "SWIFT"
        label6.text = "VARIABLE"
        cardMatrix = model.cardMatrix
        reRender()

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(draggingView))
        collectionView.addGestureRecognizer(gesture)
        
        
        // xDo any additional setup after loading the view, typically from a nib.
    }
    
    @objc func draggingView(gesture: UIPanGestureRecognizer){
        
        let locationInView = gesture.location(in: collectionView)
        
        
        
        var withinBounds: Bool = (locationInView.x<300 && locationInView.x>0)&&(locationInView.y<300 && locationInView.y>0)
        
        if (withinBounds){
            let indexPath = collectionView.indexPathForItem(at: locationInView)
            collectionView(collectionView, didHighlightItemAt: indexPath!)
            if(!currentSelectionCells.contains(indexPath!)){
                currentSelectionCells.append(indexPath!)
                let cell = collectionView.cellForItem(at: indexPath!) as! CardCollectionViewCell
                if(submittedString.count < 10){
                    submittedString.append((cell.card?.value)!)
                }
                
                selectionLabel.text = submittedString
            }
            
            
            if (gesture.state == .ended){
                for x in currentSelectionCells{
                    collectionView(collectionView, didUnhighlightItemAt: x)
                    
                }
                
                if checkAgainstWordBank(str: submittedString){
                    for x in currentSelectionCells{
                        let cell = collectionView.cellForItem(at: x) as! CardCollectionViewCell
                        cell.card?.isHighlighted = true
                    }
                    if(wordsFound < maxWordsFound){
                        wordsFound += 1
                    }
                    
                    scoreLabel.text = "Found "+String(wordsFound)+"/6"
                    
                    reRender()
                }
                selectionLabel.text = ""
                if (wordsFound == 6){
                    selectionLabel.text = "You Won!"
                    doneButton.setTitle("New Game?", for: .normal)
                    selectionLabel.textColor = getRandomColor()
                    winCondition = true
                }
                print(submittedString)
                submittedString = ""
                currentSelectionCells = []
                currentSelection = []
            }
        }
        else {
            
            for x in currentSelectionCells{
                collectionView(collectionView, didUnhighlightItemAt: x)
                
            }
            
            submittedString = ""
            currentSelectionCells = []
            currentSelection = []
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardMatrix[indexPath.section][indexPath.row]
        cell.setCard(card)
        
        cellArray.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell

        let card = cardMatrix[indexPath.section][indexPath.row]

//        if card.isFlipped == false{
//            cell.flip()
//            currentSelection.append("a")
//        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didUnselectItemAt indexPath: IndexPath) {
        
        
    }
    
    

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardMatrix[indexPath.section][indexPath.row]
        cell.flip()

        card.isFlipped=true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cardMatrix[indexPath.section][indexPath.row]
//        if heldDown{
//            currentSelection.append(cell.labelView.text!)
//        }
//        else{
//
//        }
        
        if(!(cell.card?.isHighlighted)!){
            cell.flipBack()
        }
    }
    
    
    
    func checkAgainstWordBank(str:String) -> Bool{
        
        if str == "OBJECTIVEC"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "OBJECTIVEC")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label1.textColor = getRandomColor()
            label1.attributedText = attributeString
            return true
        }
        if str == "KOTLIN"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "KOTLIN")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label2.textColor = getRandomColor()
            label2.attributedText = attributeString
            return true
        }
        if str == "MOBILE"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "MOBILE")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label3.textColor = getRandomColor()
            label3.attributedText = attributeString
            return true
        }
        if str == "SWIFT"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "SWIFT")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label5.textColor = getRandomColor()
            label5.attributedText = attributeString
            return true
        }
        if str == "JAVA"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "JAVA")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label4.textColor = getRandomColor()
            label4.attributedText = attributeString
            return true
        }
        if str == "VARIABLE"{
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "VARIABLE")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            label6.textColor = getRandomColor()
            label6.attributedText = attributeString
            return true
        }
        return false
    }
    
    func unStrikeThrough(str:NSMutableAttributedString)->NSMutableAttributedString{
        
        str.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, str.length))
        
        return str
    }

    func revealAll(){
        for x in cellArray{
            if (x.card?.isOccupied)!{
                x.card?.isHighlighted = true
            }
        }
        reRender()
        
    }
    
    func unRevealAll(){
        for x in cellArray{
            (x.card!.isHighlighted) = false
        }
        label1.textColor = .black
        label2.textColor = .black
        label3.textColor = .black
        label4.textColor = .black
        label5.textColor = .black
        label6.textColor = .black
        reRender()
        
    }
    
    
    func reRender(){
        for x in cellArray{
            x.updateLabel()
            
        }
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }

}

