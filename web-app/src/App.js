import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';
import AddOrganisation from './components/AddOrganisation/AddOrganisation';
//Higher Order Components
import HomePage from './components/home/HomePage';
import Locations from './components/Locations/Locations';
import Organisation from './components/Organisations/Organisation';
import Registration from './components/Registrations/Registration';
import SignIn from './components/SignIn/SignIn';
import SignUp from './components/SignUp/SignUp';
import './index.css';

class App extends Component {
  render() {
    return (
      <Switch>
        <Route exact path="/" component={HomePage} />
        <Route exact path="/signIn" component={SignIn} />
        <Route exact path="/signUp" component={SignUp} />
        <Route exact path="/organisations" component={Organisation} />
        <Route exact path="/addOrganisation" component={AddOrganisation} />
        <Route exact path="/locations" component={Locations} />
        <Route exact path="/registration" component={Registration} />
      </Switch>
    );
  }
}

const mapStateToProps = ({ firebase, auth }) => ({
  loggedIn: !!firebase.auth.uid,
});

const mapDispatchToProps = {};

export default connect(mapStateToProps, mapDispatchToProps)(App);
