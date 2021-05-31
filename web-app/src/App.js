import React, { Component, useEffect, useState } from 'react';
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

function App(props) {
  // const [scriptAttached, setScriptAttached] = useState(true);
  useEffect(() => {
    const scriptEl = document.createElement('script');
    scriptEl.type = "text/javascript"
    scriptEl.textContent = "function googleTranslateElementInit() { new google.translate.TranslateElement({pageLanguage: 'en', layout: google.translate.TranslateElement.InlineLayout.HORIZONTAL}, 'google_translate_element');}"
    scriptEl.async = true;
    document.body.appendChild(scriptEl);
    console.log('translation script added');
  },[])
  const [dimensions, setDimensions] = React.useState({ 
    height: window.innerHeight,
    width: window.innerWidth
  });
  useEffect(() => {
    function handleResize() {
      setDimensions({
        height: window.innerHeight,
        width: window.innerWidth
      })
    }
    window.addEventListener('resize', handleResize)
  
    return _ => {
        window.removeEventListener('resize', handleResize)
    }
})
  return (
    <Switch>
      <PublicRoute exact path="/"><HomePage  dimensions={dimensions} /> </PublicRoute>
      <PublicRoute exact path="/download"> <DownloadPage  dimensions={dimensions} /> </PublicRoute>
      <AuthRoute exact path="/signIn"> <SignIn  dimensions={dimensions} /> </AuthRoute>
      <AuthRoute exact path="/signUp"> <SignUp  dimensions={dimensions} /> </AuthRoute>
      <PrivateRoute exact path="/organizations"> <Organisation  dimensions={dimensions} /> </PrivateRoute>
      <PrivateRoute exact path="/addOrganisation"> <AddOrganisation dimensions={dimensions}/> </PrivateRoute>
      <PrivateRoute exact path="/locations/:UserName"> <LocationIndex  dimensions={dimensions} /> </PrivateRoute>
      <PrivateRoute exact path="/registration"> <Registration  dimensions={dimensions} /> </PrivateRoute>
      <PrivateRoute exact path="/registration/:UserName"> <Registration  dimensions={dimensions} /> </PrivateRoute>
      <PrivateRoute exact path="/companyInfo/:CompanyId"> <CompanyInfo  dimensions={dimensions} /> </PrivateRoute >
      <PrivateRoute exact path="/userProfile"> <UserProfile  dimensions={dimensions} /> </PrivateRoute>
      <PrivateRoute exact path="/qrpage/:CompanyId"> <QRpage  dimensions={dimensions} /> </PrivateRoute>
      <PublicRoute component={NotFound} />
    </Switch>
  );
}

const mapStateToProps = ({ firebase, auth }) => ({
  loggedIn: !!firebase.auth.uid,
});

const mapDispatchToProps = {};

export default connect(mapStateToProps, mapDispatchToProps)(App);
