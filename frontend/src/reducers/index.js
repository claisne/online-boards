import { combineReducers } from 'redux';

import uid from './uid';
import online from './online';
import games from './games';

const reducers = combineReducers({
  uid,
  online,
  games,
});

export default reducers;
