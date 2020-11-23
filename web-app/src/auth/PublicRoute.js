import React from 'react';
import { connect } from 'react-redux';
import { Route } from 'react-router-dom';

const PublicRoute = ({
  component: Component,
  userIsAuthenticated,
  ...rest
}) => (
  <Route
    {...rest}
    render={(props) => {
      return <Component {...props} />;
    }}
  />
);

const mapStateToProps = ({ auth }) => ({
  userIsAuthenticated: !!auth.auth.user,
});

export default connect(mapStateToProps)(PublicRoute);
