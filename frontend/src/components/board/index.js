import range from 'lodash/range';
import React from 'react';
import './index.css';

import Square from './square';

const pieceKey = (piece) => {
  if (piece == null) {
    return '.';
  }

  return `${piece.color}-${piece.type}`;
};

const Board = ({
  size,
  pieces,
  className,
}) => {
  const board = range(size).map(() => range(size).map(() => null));

  pieces.forEach((piece) => {
    board[piece.x][piece.y] = piece;
  });

  const lines = board.map((line, i) => {
    const squares = line.map((piece, j) => (
      <Square
        i={i}
        j={j}
        piece={piece}
        key={`${i}${j}${pieceKey(piece)}`}
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
};

export default Board;

export const DefaultStartingBoard = ({ size, className }) => {
  const pieces = [];

  for (let i = 0; i < (size / 2) - 1; i += 1) {
    for (let j = 0; j < size; j += 1) {
      if ((i % 2 === 1 && j % 2 === 0) || (i % 2 === 0 && j % 2 !== 0)) {
        pieces.push({
          type: 'man',
          color: 'black',
          x: i,
          y: j,
        });
      }
    }
  }

  for (let i = size - 1; i > (size / 2); i -= 1) {
    for (let j = 0; j < size; j += 1) {
      if ((i % 2 === 1 && j % 2 === 0) || (i % 2 === 0 && j % 2 !== 0)) {
        pieces.push({
          type: 'man',
          color: 'white',
          x: i,
          y: j,
        });
      }
    }
  }

  return (
    <Board
      size={size}
      pieces={pieces}
      className={className}
    />
  );
};
