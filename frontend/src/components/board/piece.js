import React from 'react';

import whiteMan from './img/white_man.svg';
import blackMan from './img/black_man.svg';
import whiteKing from './img/white_king.svg';
import blackKing from './img/black_king.svg';

const Piece = ({ color, type }) => {
  if (type === 'man') {
    return (
      <img alt={`${color} man`} src={color === 'white' ? whiteMan : blackMan} />
    );
  }

  if (type === 'king') {
    return (
      <img alt={`${color} king`} src={color === 'white' ? whiteKing : blackKing} />
    );
  }

  return null;
};

export default Piece;
