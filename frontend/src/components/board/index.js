import range from 'lodash/range';
import React from 'react';
import './index.css';

import Square from './square';

const pieceKey = (piece) => {
  if (piece == null) {
    return '.';
  }

  return piece;
};

class Board extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      selected: null,
    };
  }

  onClick(i, j) {
    const { selected } = this.state;
    
    if (selected == null) {
      this.setState({ selected: { i, j } });
      return;
    }

    this.setState({ selected: selected == null ? { i, j } : null });
  }

  render() {
    const { board, className } = this.props;
    const { selected } = this.state;

    const lines = board.map((line, i) => {
      const squares = line.map((piece, j) => (
        <Square
          i={i}
          j={j}
          selected={selected && selected.i === i && selected.j === j}
          piece={piece}
          key={`${i}${j}${pieceKey(piece)}`}
          onClick={() => this.onClick(i, j, piece)}
        />
      ));

      return (
        <div
          className="board-line"
          key={`${i}-${line.map(p => pieceKey(p)).join('')}`}
        >
          {squares}
        </div>
      );
    });

    return (
      <div className={`board ${className}`}>
        {lines}
      </div>
    );
  }
}

export default Board;

export const DefaultStartingBoard = ({ size, className }) => {
  const board = range(size).map(() => range(size).map(() => null));

  for (let i = 0; i < (size / 2) - 1; i += 1) {
    for (let j = 0; j < size; j += 1) {
      if ((i % 2 === 1 && j % 2 === 0) || (i % 2 === 0 && j % 2 !== 0)) {
        board[i][j] = 'm';
      }
    }
  }

  for (let i = size - 1; i > (size / 2); i -= 1) {
    for (let j = 0; j < size; j += 1) {
      if ((i % 2 === 1 && j % 2 === 0) || (i % 2 === 0 && j % 2 !== 0)) {
        board[i][j] = 'M';
      }
    }
  }

  return (
    <Board
      board={board}
      className={className}
    />
  );
};
