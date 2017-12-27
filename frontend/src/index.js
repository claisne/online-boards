import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { createLogger } from 'redux-logger';

import 'bootstrap/dist/css/bootstrap-reboot.css';
import 'bootstrap/dist/css/bootstrap-grid.css';
import './index.css';

import history from './utils/history';

import reducers from './reducers';
import * as Online from './reducers/online';
import * as Games from './reducers/games';

import { listen } from './socket';

import App from './app';

const logger = createLogger({
  predicate: (getState, action) => {
    const filtered = {
      'ONLINE/SET': true,
    };

    return filtered[action.type] !== true;
  },
});

const store = createStore(reducers, applyMiddleware(logger));

ReactDOM.render((
  <Provider store={store}>
    <App />
  </Provider>
), document.getElementById('root'));

listen('SOCKET_COUNT', ({ count }) => store.dispatch(Online.set(count)));

listen('GAME_CREATED', ({ game }) => {
  store.dispatch(Games.set(game));
  history.push(`/games/${game.uid}`);
});
