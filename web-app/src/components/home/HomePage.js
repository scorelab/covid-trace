import React, { Component } from 'react';
import { connect } from 'react-redux';

class HomePage extends Component {
  render() {
    return <div>Home page</div>;
  }
}

const mapStateToProps = ({ firebase }) => ({
  loggedIn: !!firebase.auth.uid,
});

export default connect(mapStateToProps)(HomePage);
