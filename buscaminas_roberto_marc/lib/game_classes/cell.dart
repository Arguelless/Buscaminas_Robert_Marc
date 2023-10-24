class Cell {
  bool isMine;
  bool isRevealed;
  bool isFlagged;
  int adjacentMines;

  Cell({
    required this.isMine,
    this.isRevealed = false,
    this.isFlagged = false,
    this.adjacentMines = 0,
  });
}
