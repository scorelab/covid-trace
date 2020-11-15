import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Route, Switch } from 'react-router-dom';
import AddOrganisation from './components/AddOrganisation/AddOrganisation';
import CompanyInfo from './components/CompanyInfo/CompanyInfo';
//Higher Order Components
import HomePage from './components/home/HomePage';
import Locations from './components/Locations/Locations';
import Organisation from './components/Organisations/Organisation';
import QRpage from './components/QRcode/QRpage';
import Registration from './components/Registrations/Registration';
import SignIn from './components/SignIn/SignIn';
import SignUp from './components/SignUp/SignUp';
import UserProfile from './components/UserProfile/UserProfile';
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
        <Route exact path="/locations/:UserName" component={Locations} />
        <Route exact path="/registration" component={Registration} />
        <Route exact path="/companyInfo/:CompanyId" component={CompanyInfo} />
        <Route exact path="/userProfile" component={UserProfile} />
        <Route exact path="/qrpage/:CompanyId" component={QRpage} />
      </Switch>
    );
  }
}

const mapStateToProps = ({ firebase, auth }) => ({
  loggedIn: !!firebase.auth.uid,
});

const mapDispatchToProps = {};

export default connect(mapStateToProps, mapDispatchToProps)(App);
