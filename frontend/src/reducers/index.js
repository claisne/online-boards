import { combineReducers } from 'redux';

import online from './online';
import games from './games';

const reducers = combineReducers({
  online,
  games,
});

export default reducers;
