
import React from 'react';
import { connect } from 'react-redux';
import './index.css';

import DefaultLayout from '../../layouts/default';

import Board from '../../components/board';

const Games = ({ match, games }) => {
  const game = games[match.params.id];

  if (game == null) {
    return (
      <DefaultLayout />
    );
  }

  return (
    <DefaultLayout>
      <div className="games">
        <div className="games-board-container">
          <Board
            board={game.board}
            className="games-board"
          />
        </div>
      </div>
    </DefaultLayout>
  );
};

function mapStateToProps({ games }) {
  return { games };
}

function mapDispatchToProps() {
  return {};
}

export default connect(mapStateToProps, mapDispatchToProps)(Games);
