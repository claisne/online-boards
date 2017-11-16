import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import './index.css';

import logo from './img/logo.svg';

// const ConnectedLinks = ({ username }) => (
//   <div className="navbar-auth">
//     <Link to="/sign_in" className="navbar-link">
//       {username}
//     </Link>
//   </div>
// );

// const NotConnectedLinks = () => (
//   <div className="navbar-auth">
//     <Link to="/sign_in" className="navbar-link">
//       Sign in
//     </Link>
//     <small>or</small>
//     <Link to="/register" className="navbar-link">
//       Register
//     </Link>
//   </div>
// );

const Navbar = () => (
  <nav className="navbar">
    <Link to="/" className="navbar-title">
      <img alt="Online Boards" src={logo} />
      Online Boards
      <span className="navbar-title-version">Alpha</span>
    </Link>
    <div className="navbar-links">
      {/* <Link to="/play" className="navbar-link">
        Play
      </Link> */}
    </div>
    {/* {user == null ? <NotConnectedLinks /> : <ConnectedLinks username={user.name} />} */}
  </nav>
);

function mapStateToProps({ user }) {
  return { user };
}

function mapDispatchToProps() {
  return {};
}

export default connect(mapStateToProps, mapDispatchToProps)(Navbar);

