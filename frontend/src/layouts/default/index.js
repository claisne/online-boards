import React from 'react';

import Navbar from '../../components/navbar';

import './index.css';

const Default = ({ children }) => (
  <div className="default-layout">
    <Navbar />
    <div className="default-layout-body">
      {children}
    </div>
  </div>
);

export default Default;
