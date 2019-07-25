# Helper Method
require "pry"


WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]
PLAYERS = ["X", "O"]  
$winningcombo = -1 


def won?(board)
  result = winner(board)
  if result == nil 
    return false  
  end
  return WIN_COMBINATIONS[$winningcombo]
end

def play(board)
  result = won?(board)
  
  if isover == false 
    puts "Welcome to Tic Tac Toe!"
    display_board(board)
    while isover == false
      puts "It's player #{current_player(board)}'s turn" 
      turn(board)
      result = won?(board)
      isover = over?(board)
    end
  end
  
  if isover
    
    
    if result
      newresult = won?(board)
      puts newresult.class
      binding.pry
      firstlocation = newresult[0]
     # puts firstlocation
      #puts "Congratulations #{board[firstlocation]}!"
    end
  end
    
  
end

def winner(board)
  winnerfound = false 
  PLAYERS.each do |i|
    if iswinner(board, i) == i 
      return i 
      winnerfound = true
      break
    end
  end
  if winnerfound == false
    return nil  
  end
end

def iswinner(board, player)
  winfound = false 
  complete = false
  combo = []
  combinationcounter = 0
   
  until complete == true 
    while combinationcounter < WIN_COMBINATIONS.length 
      combo = WIN_COMBINATIONS[combinationcounter]
      combocounter = 0
      playercounter = 0
      while combocounter < combo.length
       boardcontent = board[combo[combocounter]]
        if boardcontent == player
          playercounter += 1  
        end 
        combocounter += 1
      end
      if playercounter == 3
        winfound = true 
        complete = true
        $winningcombo = combinationcounter
        break
      end
      combinationcounter += 1
    end
    complete = true 
  end
  if winfound == true 
    return player  
  end
end

def full?(board)
  isfull = true 
  board.each do |location|
    if location == " "
      isfull = false 
      break 
    end
  end
  return isfull
end