
import createReducer from '../utils/create-reducer';

const SET = 'GAMES/SET';

const initialState = {};

export default createReducer(initialState, {
  [SET](state, { game }) {
    return { [game.uid]: game };
  },
});

export function set(game) {
  return { type: SET, game };
}
