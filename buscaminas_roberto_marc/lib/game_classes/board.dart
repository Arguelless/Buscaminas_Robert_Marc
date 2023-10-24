import 'cell.dart';
import 'dart:math';

class Board {
  final int numRows;
  final int numCols;
  final int numMines;
  List<List<Cell>> grid = [];

  Board({
    required this.numRows,
    required this.numCols,
    required this.numMines,
  }) {
    // Inicializa el tablero con celdas vacías
    grid = List.generate(numRows, (r) {
      return List.generate(numCols, (c) {
        return Cell(isMine: false);
      });
    });

    // Coloca las minas en ubicaciones aleatorias
    _placeMines();
  }

  void _placeMines() {
    final random = Random();
    int minesPlaced = 0;

    while (minesPlaced < numMines) {
      final row = random.nextInt(numRows);
      final col = random.nextInt(numCols);

      // Verifica si la celda ya tiene una mina
      if (!grid[row][col].isMine) {
        grid[row][col].isMine = true;
        minesPlaced++;
      }
    }
  }
}
