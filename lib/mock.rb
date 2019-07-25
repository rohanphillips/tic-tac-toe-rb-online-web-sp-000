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
  #for the purpose of this study, winner(board) returns nil or "X" or "O"
  result = winner(board)
  if result == nil 
    #if the result of winner is null, return false
    return false  
  end
  #return the array at location 0
  return WIN_COMBINATIONS[0]
end

def play(board)
  #i'm attempting to assign the return of the won? method to result
  result = won?(board)
  #when result is evaluated, when an array is being returned, result becomes true or false,
  #rather than what I'd expect as false or an array
end
