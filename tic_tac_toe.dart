import 'dart:io';

class TicTacToeGame {
  List<String> gameBoard;
  String currentPlayer;

  TicTacToeGame() {
    gameBoard = List.filled(9, ' ');
    currentPlayer = 'X';
  }

  void displayBoard() {
    print('Tic-Tac-Toe Game\n');
    for (int i = 0; i < 9; i += 3) {
      print(' ${gameBoard[i]} | ${gameBoard[i + 1]} | ${gameBoard[i + 2]} ');
      if (i < 6) print('---+---+---');
    }
    print('\n');
  }

  bool makeMove(int position) {
    if (position < 1 || position > 9 || gameBoard[position - 1] != ' ') {
      print('Invalid move. Please try again.');
      return false;
    }

    gameBoard[position - 1] = currentPlayer;
    return true;
  }

  bool checkForWinner() {
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i] == currentPlayer &&
          gameBoard[i + 3] == currentPlayer &&
          gameBoard[i + 6] == currentPlayer) {
        return true;
      }
      if (gameBoard[i * 3] == currentPlayer &&
          gameBoard[i * 3 + 1] == currentPlayer &&
          gameBoard[i * 3 + 2] == currentPlayer) {
        return true;
      }
    }

    if ((gameBoard[0] == currentPlayer && gameBoard[4] == currentPlayer && gameBoard[8] == currentPlayer) ||
        (gameBoard[2] == currentPlayer && gameBoard[4] == currentPlayer && gameBoard[6] == currentPlayer)) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    return !gameBoard.contains(' ');
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void startGame() {
    print('Welcome to the Dart Tic-Tac-Toe Game!\n');
    do {
      displayBoard();
      print('$currentPlayer\'s turn. Enter your move (1-9): ');
      int move = int.tryParse(stdin.readLineSync() ?? '');

      if (move != null && move >= 1 && move <= 9) {
        if (makeMove(move)) {
          if (checkForWinner()) {
            displayBoard();
            print('Congratulations! $currentPlayer wins!');
            break;
          } else if (isBoardFull()) {
            displayBoard();
            print('It\'s a draw!');
            break;
          } else {
            switchPlayer();
          }
        }
      } else {
        print('Invalid input. Please enter a number between 1 and 9.');
      }
    } while (true);
  }
}

void main() {
  TicTacToeGame game = TicTacToeGame();
  game.startGame();
}
