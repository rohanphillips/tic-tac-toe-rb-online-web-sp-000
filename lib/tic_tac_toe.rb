# Helper Method
require "pry"

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(i)
  userinput = i.strip
  input = userinput.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def update_array_at_with(array, index, value)
  array[index] = value
end

def valid_move?(board, move)
  if move.between?(0,8)
    if position_taken?(board, move) == false 
      return true 
    else
      return false 
    end
  else
    return false 
  end
end


def turn_count(board)
  i = 0 
  turncount = 0 
  while i < board.length
    if board[i] != " "
      turncount += 1 
    end
    i += 1
  end
  return turncount
end

def current_player(board)
  xcount = 0 
  ocount = 0 
  currentplayer = "X"
  if turn_count(board) < 10
    board.each do |n|
      if n == "X"
        xcount += 1 
      elsif n == "O"
        ocount += 1 
      end
    end
    if xcount > ocount
      currentplayer = "O"
    end 
  end
  return currentplayer
end

# Define your WIN_COMBINATIONS constant
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



def draw?(board)
  result = won?(board)
  isarray = result.class == Array
  fullboard = full?(board)
  if result == false && fullboard == true 
    #board is full and no winner
    return true 
  elsif result 
    #there was a winner, therefore no draw
    return false
  elsif result == false && fullboard == false 
    #game is still in progress
    return false
  else
      #any other result would suggest a draw
      return true
  end
  
end

def over?(board)
  return draw?(board) == true || won?(board) != false || full?(board) == true 
end

def turn(board)
 valid = false 
 while valid == false
  puts "Please enter 1-9:"
  mymove = input_to_index(gets.strip)
  if valid_move?(board, mymove)
    if position_taken?(board, mymove) == false
      move(board, mymove, current_player(board))
      valid = true 
    end
  end
 end
 display_board(board)
end

def won?(board)
  result = winner(board)
  if result == nil 
    return false  
  end
  return WIN_COMBINATIONS[$winningcombo]
end

def play(board)
  isover = over?(board)
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
    result = won?(board)
    if result
      puts "Congratulations #{winner(board)}!"
    end
    if draw?(board) == true
      puts "Cat's Game!"
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