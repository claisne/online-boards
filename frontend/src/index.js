import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import logger from 'redux-logger';

import 'bootstrap/dist/css/bootstrap-reboot.css';
import 'bootstrap/dist/css/bootstrap-grid.css';
import './index.css';

import reducers from './reducers';
import * as Online from './reducers/online';

import { listen } from './socket';

import App from './app';

const store = createStore(reducers, applyMiddleware(logger));

ReactDOM.render((
  <Provider store={store}>
    <App />
  </Provider>
), document.getElementById('root'));

listen('SOCKET_COUNT', ({ count }) => store.dispatch(Online.set(count)));
