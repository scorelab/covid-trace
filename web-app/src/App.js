import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Switch } from 'react-router-dom';
// route guards
import AuthRoute from './auth/AuthRoute';
import PrivateRoute from './auth/PrivateRoute';
import PublicRoute from './auth/PublicRoute';
import AddOrganisation from './components/AddOrganisation/AddOrganisation';
import CompanyInfo from './components/CompanyInfo/CompanyInfo';
import DownloadPage from './components/Download/DownloadPage';
//Higher Order Components
import HomePage from './components/home/HomePage';
import LocationIndex from './components/Locations/LocationIndex';
import NotFound from './components/NotFound/NotFound';
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
        <PublicRoute exact path="/" component={HomePage} />
        <PublicRoute exact path="/download" component={DownloadPage} />
        <AuthRoute exact path="/signIn" component={SignIn} />
        <AuthRoute exact path="/signUp" component={SignUp} />
        <PrivateRoute exact path="/organizations" component={Organisation} />
        <PrivateRoute
          exact
          path="/addOrganisation"
          component={AddOrganisation}
        />
        <PrivateRoute
          exact
          path="/locations/:UserName"
          component={LocationIndex}
        />
        <PrivateRoute exact path="/registration" component={Registration} />
        <PrivateRoute exact path="/registration/:UserName" component={Registration} />
        <PrivateRoute
          exact
          path="/companyInfo/:CompanyId"
          component={CompanyInfo}
        />
        <PrivateRoute exact path="/userProfile" component={UserProfile} />
        <PrivateRoute exact path="/qrpage/:CompanyId" component={QRpage} />
        <PublicRoute component={NotFound} />
      </Switch>
    );
  }
}

const mapStateToProps = ({ firebase, auth }) => ({
  loggedIn: !!firebase.auth.uid,
});

const mapDispatchToProps = {};

export default connect(mapStateToProps, mapDispatchToProps)(App);
