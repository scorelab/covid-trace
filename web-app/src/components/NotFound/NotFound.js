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
      <p>Page Not Found</p>
    </div>
  </div>
);

export default NotFound;
