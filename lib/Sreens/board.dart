import 'dart:async';
import 'dart:math';
import 'package:block_puzzel_game/Components/pixel.dart';
import 'package:block_puzzel_game/Components/value.dart';
import 'package:flutter/material.dart';

import '../Components/piece.dart';

List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);

  int currentScore = 0;
  bool gameOver = false;

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text('Your Score is : $currentScore'),
        actions: [
          TextButton(
              onPressed: () {
                resetGame();
                Navigator.pop(context);
              },
              child: const Text('Play Again'))
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard =
        List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

    gameOver = false;
    currentScore = 0;

    createNewPiece();

    startGame();
  }

  // check collisen
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength ||
          col < 0 ||
          col >= rowLength ||
          (row >= 0 && gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    return false;
  }

  @override
  void initState() {
    startGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rowLength * colLength,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  itemBuilder: (context, index) {
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;
                    if (currentPiece.position.contains(index)) {
                      return Pixel(
                        color: currentPiece.color,
                        child: index,
                      );
                    } else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(
                          color: tetrominoColors[tetrominoType], child: '');
                    } else {
                      return Pixel(
                        color: Colors.grey[900],
                        child: index,
                      );
                    }
                  }),
            ),
            Text(
              'Score : $currentScore',
              style: TextStyle(color: Colors.white,fontSize: width * 0.038),
            ),
            Padding(
              padding:
                  EdgeInsets.only(bottom: height * 0.051, top: height * 0.042),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 38,
                      )),
                  IconButton(
                      onPressed: rotatePiece,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.rotate_right,
                        size: 38,
                      )),
                  IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 38,
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
