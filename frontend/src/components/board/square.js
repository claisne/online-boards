import React from 'react';

import Piece from './piece';

const Square = ({ i, j, piece }) => {
  const isWhite = (i % 2 === 0 && j % 2 === 0) || (i % 2 !== 0 && j % 2 !== 0);

  return (
    <div className={`square square-${isWhite ? 'white' : 'black'}`}>
      {piece != null ? <Piece {...piece} /> : null}
    </div>
  );
};

export default Square;
