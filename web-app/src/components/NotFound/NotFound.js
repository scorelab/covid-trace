import React from 'react';
import Navbar from '../UiElements/Navbar/Navbar';

const NotFound = () => (
  <div>
    <Navbar />
    <div
      style={{
        display: 'flex',
        justifyContent: 'center',
      }}
    >
      <p>Page not found</p>
    </div>
  </div>
);

export default NotFound;
