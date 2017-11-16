import React from 'react';
import { Router, Route } from 'react-router-dom';

import history from './utils/history';

import Home from './pages/home';
import Play from './pages/play';
import SignIn from './pages/account/sign_in';
import Register from './pages/account/register';

const App = () => (
  <Router history={history}>
    <div className="app">
      <Route exact path="/" component={Home} />
      <Route exact path="/play" component={Play} />
      <Route exact path="/sign_in" component={SignIn} />
      <Route exact path="/register" component={Register} />
    </div>
  </Router>
);

export default App;
