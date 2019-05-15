//
//  CardModel.swift
//  ShopifyInternMobileApp
//
//  Created by Kelley Zhang on 5/12/19.
//  Copyright © 2019 Kelley Zhang. All rights reserved.
//

import Foundation

class CardModel {
    var wordBank = ["SWIFT","MOBILE","OBJECTIVEC","KOTLIN", "VARIABLE", "JAVA"]
    var charLibrary = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var cardArray: [Card] = []
    var cardMatrix: [[Card]] = []
    var numCols = 10
    var numRows = 10
    func getCards() {
        cardMatrix = []
        cardArray = []
        for i in 0...9 {
            cardMatrix.append([])
            for j in 0...9{
                
                let newCard = Card()
                var randCharInd = Int(arc4random_uniform(26))
                var randChar = charLibrary[randCharInd]
                newCard.setValue(str: randChar)
                cardMatrix[i].append(newCard)
                cardArray.append(newCard)
            }
            
        }
        
    }

    
    func getCards2() -> [Card] {
        var generatedCardsArray = [Card]()
        
        for _ in 1...100 {
            let newCard = Card()
            var randCharInd = Int(arc4random_uniform(26))
            var randChar = charLibrary[randCharInd]
            newCard.setValue(str: randChar)
            generatedCardsArray.append(newCard)
        }
        return generatedCardsArray
    }
    
    func placeWord(word: String){
        //pick random point
        
        var dir: [[Int]] = []
        var randSect = Int(arc4random_uniform(10))
        var randRow = Int(arc4random_uniform(10))
        while(dir.count == 0){
            randSect = Int(arc4random_uniform(10))
            randRow = Int(arc4random_uniform(10))
            dir = getDirections(sect: randSect, row: randRow, word: word)
        }
        var randDirIndex = Int(arc4random_uniform(UInt32(dir.count)))
        var randDir = dir[randDirIndex]
        var deltaSect = randDir[0]
        var deltaRow = randDir[1]
        
        var indexCounter = 0
        for i in word{
            print(randSect+deltaSect*indexCounter)
            print(randRow+deltaRow*indexCounter)
            cardMatrix[randSect+deltaSect*indexCounter][randRow+deltaRow*indexCounter].setValue(str: String(i))
            cardMatrix[randSect+deltaSect*indexCounter][randRow+deltaRow*indexCounter].isOccupied = true
            
            if(cardMatrix[randSect+deltaSect*indexCounter][randRow+deltaRow*indexCounter].isOccupied){
                print("boo")
            }
            indexCounter += 1
        }
    }
    
    
    //get a valid direction
    func getDirections(sect: Int, row: Int, word: String) -> [[Int]]{
        let up = [-1, 0]
        let down = [1, 0]
        let left = [0, -1]
        let right = [0, 1]
        let upLeft = [-1, -1]
        let doLeft = [1, -1]
        let upRight = [-1, 1]
        let doRight = [1, 1]
        var validDirections: [[Int]] = []
        let wordLen = word.count
        
        var upBool = true
        var downBool = true
        var leftBool = true
        var rightBool = true
        var upLeftBool = true
        var doLeftBool = true
        var upRightBool = true
        var doRightBool = true
        
        //check if right works
        var wordIndexCounter = 0
        for i in word{
            if(row + word.count - 1 < numCols) {
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect][row+wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    rightBool = false
                }
            }
            else {
                // not enough space
                rightBool = false
            }
            wordIndexCounter += 1
        }
        wordIndexCounter = 0
        if rightBool {
            validDirections.append(right)
        }
        
        
        //check if left works
        wordIndexCounter = 0
        for i in word{
            if(row - (word.count - 1) >= 0) {
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect][row-wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    leftBool = false
                }
            }
            else {
                // not enough space
                leftBool = false
            }
            wordIndexCounter += 1
        }
        wordIndexCounter = 0
        if leftBool {
            validDirections.append(left)
        }
        
        //check if up works
        wordIndexCounter = 0
        for i in word{
            if(sect - (word.count - 1) >= 0) {
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect-wordIndexCounter][row])) {
                    // do nothing
                } else {
                    // conflicting letter
                    upBool = false
                }
            }
            else {
                // not enough space
                upBool = false
            }
            wordIndexCounter += 1
        }
        wordIndexCounter = 0
        if upBool {
            validDirections.append(up)
        }
        
        
        //check if down works
        wordIndexCounter = 0
        for i in word{
            if(sect + (word.count - 1) < numRows) {
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect+wordIndexCounter][row])) {
                    // do nothing
                } else {
                    // conflicting letter
                    downBool = false
                }
            }
            else {
                // not enough space
                downBool = false
            }
            wordIndexCounter += 1
        }
        wordIndexCounter = 0
        if downBool {
            validDirections.append(down)
        }
        
        //check if upLeft works
        wordIndexCounter = 0
        for i in word{
            if(upBool && leftBool){
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect-wordIndexCounter][row-wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    upLeftBool = false
                }
            }
            else{
                upLeftBool = false
            }
            wordIndexCounter += 1
        }
        if upLeftBool{
            validDirections.append(upLeft)
        }
        
        //check if upRight works
        wordIndexCounter = 0
        for i in word{
            if(upBool && rightBool){
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect-wordIndexCounter][row+wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    upRightBool = false
                }
            }
            else{
                upRightBool = false
            }
            wordIndexCounter += 1
        }
        if upRightBool{
            validDirections.append(upRight)
        }
        
        //check if doLeft works
        wordIndexCounter = 0
        for i in word{
            if(downBool && leftBool){
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect+wordIndexCounter][row-wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    doLeftBool = false
                }
            }
            else{
                doLeftBool = false
            }
            wordIndexCounter += 1
        }
        if doLeftBool{
            validDirections.append(doLeft)
        }
        
        //check if doRight works
        wordIndexCounter = 0
        for i in word{
            if(downBool && rightBool){
                if(isCellAvailable(letter: String(i), neighbor: cardMatrix[sect+wordIndexCounter][row+wordIndexCounter])) {
                    // do nothing
                } else {
                    // conflicting letter
                    upLeftBool = false
                }
            }
            else{
                doRightBool = false
            }
            wordIndexCounter += 1
        }
        if upLeftBool{
            validDirections.append(upLeft)
        }
        
        
        print("start----------")
        print(leftBool)
        print(rightBool)
        print(upBool)
        print(downBool)
        print(validDirections)
        print("end----------")
        //get random direction from validDirections
        return validDirections
        
    }
    
    func isCellAvailable(letter: String, neighbor: Card)->Bool{
        if neighbor.isOccupied{
            print("intersection")
        }
        if(!neighbor.isOccupied || neighbor.value == letter){
            return true
        }
        else {
            return false
        }
    }
    
}
