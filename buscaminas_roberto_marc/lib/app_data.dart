import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'game_classes/board.dart';

class AppData with ChangeNotifier {
  // App status
  String midaTaulell = "petit";
  String numeroMines = "5";

  List<List<String>> board = [];
  bool gameIsOver = false;
  String gameWinner = '-';

  ui.Image? imagePlayer;
  ui.Image? imageOpponent;
  bool imagesReady = false;

  void setMidaTaulell(String value, String mines) {
    if (value == "petit") {
      final Board board =
          Board(numRows: 9, numCols: 9, numMines: (int.parse(mines)));
    } else if (value == "gran") {
      final Board board =
          Board(numRows: 15, numCols: 15, numMines: (int.parse(mines)));
    }
  }

  void resetGame() {
    board = [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-'],
    ];
    gameIsOver = false;
    gameWinner = '-';
  }

  // Fa una jugada, primer el jugador després la maquina
  void playMove(int row, int col) {
    if (board[row][col] == '-') {
      board[row][col] = 'X';
      checkGameWinner();
      if (gameWinner == '-') {
        machinePlay();
      }
    }
  }

  // Fa una jugada de la màquina, només busca la primera posició lliure
  void machinePlay() {
    bool moveMade = false;

    // Buscar una casella lliure '-'
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '-') {
          board[i][j] = 'O';
          moveMade = true;
          break;
        }
      }
      if (moveMade) break;
    }

    checkGameWinner();
  }

  // Comprova si el joc ja té un tres en ratlla
  // No comprova la situació d'empat
  void checkGameWinner() {
    for (int i = 0; i < 3; i++) {
      // Comprovar files
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '-') {
        gameIsOver = true;
        gameWinner = board[i][0];
        return;
      }

      // Comprovar columnes
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '-') {
        gameIsOver = true;
        gameWinner = board[0][i];
        return;
      }
    }

    // Comprovar diagonal principal
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != '-') {
      gameIsOver = true;
      gameWinner = board[0][0];
      return;
    }

    // Comprovar diagonal secundària
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != '-') {
      gameIsOver = true;
      gameWinner = board[0][2];
      return;
    }

    // No hi ha guanyador, torna '-'
    gameWinner = '-';
  }

  // Carrega les imatges per dibuixar-les al Canvas
  Future<void> loadImages(BuildContext context) async {
    // Si ja estàn carregades, no cal fer res
    if (imagesReady) {
      notifyListeners();
      return;
    }

    // Força simular un loading
    await Future.delayed(const Duration(milliseconds: 500));

    Image tmpPlayer = Image.asset('assets/images/player.png');
    Image tmpOpponent = Image.asset('assets/images/opponent.png');

    // Carrega les imatges
    if (context.mounted) {
      imagePlayer = await convertWidgetToUiImage(tmpPlayer);
    }
    if (context.mounted) {
      imageOpponent = await convertWidgetToUiImage(tmpOpponent);
    }

    imagesReady = true;

    // Notifica als escoltadors que les imatges estan carregades
    notifyListeners();
  }

  // Converteix les imatges al format vàlid pel Canvas
  Future<ui.Image> convertWidgetToUiImage(Image image) async {
    final completer = Completer<ui.Image>();
    image.image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(info.image),
          ),
        );
    return completer.future;
  }
/*
  int calculateAdjacentMines(int row, int col) {
    int adjacentMines = 0;

    // Coordenadas de las celdas adyacentes
    final List<int> dx = [-1, 0, 1, -1, 1, -1, 0, 1];
    final List<int> dy = [-1, -1, -1, 0, 0, 1, 1, 1];

    for (int i = 0; i < 8; i++) {
      final int newRow = row + dy[i];
      final int newCol = col + dx[i];

      // Verifica si la celda adyacente está dentro de los límites del tablero
      if (newRow >= 0 && newRow < numRows && newCol >= 0 && newCol < numCols) {
        if (grid[newRow][newCol].isMine) {
          adjacentMines++;
        }
      }
    }

    return adjacentMines;
  }

  void revealCell(int row, int col) {
    if (row < 0 || row >= numRows || col < 0 || col >= numCols) {
      return; // Verifica si estamos dentro de los límites del tablero
    }

    Cell cell = board[row][col];

    if (cell.isRevealed || cell.isFlagged || cell.isMine) {
      return; // Evita revelar celdas ya reveladas, marcadas con bandera o con minas
    }

    cell.isRevealed = true;

    if (cell.adjacentMines == 0) {
      // Si la celda no tiene minas adyacentes, propagamos la revelación
      for (int dr = -1; dr <= 1; dr++) {
        for (int dc = -1; dc <= 1; dc++) {
          revealCell(row + dr, col + dc);
        }
      }
    }
    
  }*/
}
