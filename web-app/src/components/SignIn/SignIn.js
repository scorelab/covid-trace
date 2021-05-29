import { Button, Card, Input, Layout,Spin,Alert,Row } from 'antd';
import React, { useEffect, useState } from 'react';
import { connect, connectAdvanced } from 'react-redux';
import * as actions from '../../store/actions';
import BottomFooter from '../UiElements/BottomFooter';
import Navbar from '../UiElements/Navbar/Navbar';
import { useHistory } from "react-router-dom";
import {Link} from "react-router-dom";

const { Content } = Layout;

function SignIn(props) {
  const [contactNo, setContactNo] = useState('');
  const [password, setPassword] = useState('');
  let history = useHistory();

  useEffect(() => {
    if (props.user) {
      history.push("/organizations");
    }
  }, [props.user])

  function onChangePhoneNumber(e) {
    setContactNo(e.target.value);
  }
  function onChangePassword(e) {
    setPassword(e.target.value);
  }

  const signIn = (e) => {
    e.preventDefault();
    const phoneNumber = "+94".concat(contactNo)
    props.logIn({ phoneNumber, password });
  };


  return (
    <div style={{ background: '#F2F2F2' }}>
      <Layout style={{ minHeight: '100vh' }}>
        <Navbar direct="SignUp" dir_name="Register"/>
        <Content
          style={{
            padding: '0 50px',
            display: 'flex',
            justifyContent: 'center',
          }}
        >
          <div class="col d-flex justify-content-center">


          <Card
            title="Welcome" 
            style={{
              width: 475,
              boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)',
              marginTop: '90px',
              minheight: '250px',
              maxHeight: '400px',
              textAlign: 'center'
            }}
          >   
              <form onSubmit={signIn}>
                <Row>
                  Phone number
                  <Input
                    aria-label={"Please enter your phone number in the +94 format without the +94 part"}
                    addonBefore="+94"
                    defaultValue=""
                    placeholder="Contact No"
                    style={{ marginBottom: '10px', paddingTop: '5px' }}
                    onChange={onChangePhoneNumber}
                    value={contactNo}
                    required
                  />
                </Row>
                <Row>
                  Password
                  <Input
                    aria-label="Please enter your password"
                    defaultValue=""
                    placeholder="Password"
                    type="password"
                    style={{ marginBottom: '10px', paddingTop: '5px' }}
                    onChange={onChangePassword}
                    value={password}
                    required
                  />
                </Row>
                <Row style={{ display: 'flex', justifyContent: 'center', paddingBottom: '10px' }}>
                  <Button
                      aria-label="Please click the button to Sign In"
                      type="primary"
                      style={{ marginRight: '20px',width:'140px' }}
                      //onClick={signIn}
                      htmlType="submit"
                    >
                      Sign In
                  </Button>
                </Row>
                <Row style={{ display: 'flex', justifyContent: 'center' }}>
                  <Link to="/signUp"
                    aria-label="Haven't Sign Up yet? Click here to sign up">
                    Haven't Sign Up yet? Click here to sign up
                  </Link>
                </Row>
              </form>
              <Row>
              {props.loading ?
              <div style={{ display: 'flex', justifyContent: 'flex-start' }}>
               <Spin />
               </div>
               : null}
              {props.error ? <Alert message={props.error} type="warning" showIcon closable style={{marginTop:'6px',width:'100%'}}/> : null}
              </Row>
          </Card>
          </div>
        </Content>
        <BottomFooter />
      </Layout>
    </div>
  );

}

const mapStateToProps = ({ auth }) => ({
  loading: auth.signin.loading,
  error: auth.signin.error,
  user: auth.auth.user
}
);

const mapDispatchToProps = {
  logIn: actions.signIn,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);
