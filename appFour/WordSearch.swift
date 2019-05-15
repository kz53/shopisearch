class Cell{
    var value = "-"
    var displayedValue = ""
    var color= ""
    var memberofwords = ""
    var left : Cell = 
    var left : Cell =
    var left : Cell =
    var left : Cell =
    var left : Cell =
    var left : Cell =
    var left : Cell =
    var left : Cell =

    var hidden: Bool

    public Cell(){

    }

}

class Word{
    var start = ""
    var end = ""
    var direction = ""
    var diagonal = "" 
    var backwards = ""
    var horizontal = ""
    var vertical = ""
}

var numCols = 10
var numRows = 10
var grid = [[Class]]()

for row in 0...numRows {
    for col in 0...numCols {
        grid[row][col] = cell()
    }
}

// pick random start point
var difficultyLevel
var 

func getRandomStartPoint() -> (Int, Int){
    var randX = arc4_random(numCols)
    var randY = arc4_random(numRows)
    return (randX, randY)
}

//sanitize word

// check all directions to see if word fits and pick a direction

func getDirection(row, col, word) {
    var up = (-1, 0)
    var down = (1, 0)
    var left = (0, -1)
    var right = (0, 1)
    var upLeft = (-1, -1)
    var doLeft = (1, -1)
    var upRight = (-1, 1)
    var doRight = (1, 1)
    var validDirections = []
    var wordLen = word.count
    
    var upBool = true
    var downBoold = true
    var leftBool = true
    var rightBool = true
    var upLeftBool = true
    var doLeftBool = true
    var upRightBool = true
    var doRightBool = true

    //check if right works
    for i in 0...wordLen{
        if(col + i < numCols) {
            if  (checkCellAvailability(word[i], grid[row][col+i]) {
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
    }

    if rightBool {
        validDirections.append right
    }


    //check if left works
    for i in 0...wordLen{
        if(row - i >= 0) {
            if  (checkCellAvailability(word[i], grid[row][i-1]) {
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
    }

    if leftBool {
        validDirections.append(left)
    }


    //check if up works
    for i in 0...wordLen{
        if(row - i >= 0) {
            if(checkCellAvailability(word[i], grid[row-i][col]) {
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
    }

    if upBool {
        validDirections.append(up)
    }

    //check if down works
    for i in 0...wordLen{
        if(row + i < numRows) {
            if  (checkCellAvailability(word[i], grid[row+1][col]) {
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
    }

    if downBool {
        validDirections.append right
    }

    //check if left works
    for i in 0...wordLen{
        if(row + i < numRows) {
            if  (checkCellAvailability(word[i], grid[row][i+1]) {
                // do nothing
            } else {
                // conflicting letter
                Bool = false
            }
            
        }
        else {
            // not enough space
            Bool = false
        }
    }

    if Bool {
        validDirections.append right
    }

    //check if left works
    for i in 0...wordLen{
        if(row + i < numRows) {
            if  (checkCellAvailability(word[i], grid[row][i+1]) {
                // do nothing
            } else {
                // conflicting letter
                Bool = false
            }
            
        }
        else {
            // not enough space
            Bool = false
        }
    }

    if Bool {
        validDirections.append right
    }
}

func checkCellAvailability(value, Cell){
    if (value == Cell.value){
        return true
    }
    return false
}

// placeonboard 
func placeOnBoard(word){
    var start = getRandomStartPoint()
    var direction = getDirection(start[0], start[1], word)

    for x in 1...word.count {
        grid[start[0]+x*direction][start[1]+x*direction].value == word[x]
        grid[row][col].displayedValue == word[x]
    }
}

// randomize 
func randomizeGrid(){
    for row in 1...row{
        for col in 1...row{
            if (grid[row][col].value == "-" {
                grid[row][col].value = //randomvalidcharacter
            }
        }
    }
}

// render: connect to screen

// level 1 nothing
// level 2 backwards and diagonal
// level 3 false starts
// level 4 upper and lower case
// level 5 similar characters
// level 5 color
// level 6 changing characters
// level 7 moving words
// level 8 gray
// level 9 white