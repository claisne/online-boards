import React from 'react';

import Piece from './piece';

const Square = ({ i, j, piece, selected, onClick }) => {
  const isWhite = (i % 2 === 0 && j % 2 === 0) || (i % 2 !== 0 && j % 2 !== 0);

  return (
    <div
      onClick={onClick}
      style={{ opacity: selected ? 0.7 : 1 }}
      className={`square square-${isWhite ? 'white' : 'black'}`}
    >
      {piece != null ? <Piece piece={piece} /> : null}
    </div>
  );
};

export default Square;
