import React from 'react';
import { connect } from 'react-redux';
import { Redirect, Route } from 'react-router-dom';

const PrivateRoute = ({
  component: Component,
  userIsAuthenticated,
  ...rest
}) => (
  <Route
    {...rest}
    render={(props) => {
      if (userIsAuthenticated) {
        return <Component {...props} />;
      } else {
        return <Redirect to="/signin" />;
      }
    }}
  />
);

const mapStateToProps = ({ auth }) => ({
  userIsAuthenticated: !!auth.auth.user,
});

export default connect(mapStateToProps)(PrivateRoute);
