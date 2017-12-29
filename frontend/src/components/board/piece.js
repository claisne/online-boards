import React from 'react';

import whiteMan from './img/white_man.svg';
import blackMan from './img/black_man.svg';
import whiteKing from './img/white_king.svg';
import blackKing from './img/black_king.svg';

const Piece = ({ piece }) => {
  if (piece === 'M') {
    return (
      <img
        alt="White Man"
        src={whiteMan}
      />
    );
  }

  if (piece === 'K') {
    return (
      <img
        alt="White King"
        src={whiteKing}
      />
    );
  }

  if (piece === 'm') {
    return (
      <img
        alt="Black Man"
        src={blackMan}
      />
    );
  }

  if (piece === 'k') {
    return (
      <img
        alt="Black King"
        src={blackKing}
      />
    );
  }

  return null;
};

export default Piece;
