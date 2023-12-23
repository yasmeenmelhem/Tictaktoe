import 'dart:io';

class TicTacToe {
  late List<String> board;
  late bool isPlayer1Turn;

  TicTacToe() {
    board = List.filled(9, ' ');
    isPlayer1Turn = true;
  }

  void displayBoard() {
    print(' ${board[0]} | ${board[1]} | ${board[2]} ');
    print('-----------');

    print(' ${board[3]} | ${board[4]} | ${board[5]} ');
    print('-----------');
    print(' ${board[6]} | ${board[7]} | ${board[8]} ');
  }

  bool makeMove(int position) {
    if (position < 1 || position > 9 || board[position - 1] != ' ') {
      print('Invalid move. Please choose an empty cell (1-9).');
      return false;
    }
    board[position - 1] = isPlayer1Turn ? 'X' : 'O';
    return true;
  }

  bool checkWinner() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] != ' ' &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        return true;
      }
    }

    return false;
  }

  bool checkDraw() {
    return !board.contains(' ');
  }

  void startGame() {
    print('Welcome to Tic-Tac-Toe!');
    print('Player 1: X | Player 2: O');
    print('Enter a number to make your move (1-9).');

    while (true) {
      displayBoard();
      int? move;

      do {
        print(
            '${isPlayer1Turn ? 'Player 1 (X)' : 'Player 2 (O)'} - Enter your move: ');
        move = safeParse(stdin.readLineSync());
      } while (move == null || !makeMove(move));

      if (checkWinner()) {
        displayBoard();
        print(
            '${isPlayer1Turn ? 'Player 1 (X)' : 'Player 2 (O)'} wins! Congratulations!');
        break;
      } else if (checkDraw()) {
        displayBoard();
        print('It\'s a draw!');
        break;
      }

      isPlayer1Turn = !isPlayer1Turn;
    }

    print('Do you want to play again? (yes/no)');
    String? playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain == 'yes') {
      resetBoard();
      startGame();
    } else {
      print('Thank you for playing Tic-Tac-Toe!');
    }
  }

  void resetBoard() {
    board = List.filled(9, ' ');
    isPlayer1Turn = true;
  }

  int? safeParse(String? input) {
    if (input != null && input.isNotEmpty) {
      return int.tryParse(input);
    }
    return null;
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}
