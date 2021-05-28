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
          <Card
            title="Welcome"
            style={{
              width: 475,
              boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)',
              marginTop: '131px',
              minheight: '250px',
              maxHeight: '265px',
            }}
          >
            
              <form onSubmit={signIn}>
                <Row>
                  <Input
                    addonBefore="+94"
                    defaultValue=""
                    placeholder="Contact No"
                    aria-label="Enter your contact number" 
                    aria-required="true"
                    style={{ marginBottom: '10px' }}
                    onChange={onChangePhoneNumber}
                    value={contactNo}
                    required
                  />
                </Row>
                <Row>
                  <Input
                    defaultValue=""
                    placeholder="Password"
                    type="password"
                    aria-label="Enter your password" 
                    aria-required="true"
                    style={{ marginBottom: '20px' }}
                    onChange={onChangePassword}
                    value={password}
                    required
                  />
                </Row>
                <Row style={{ display: 'flex', justifyContent: 'center' }}>
                  <Button
                      type="primary"
                      style={{ marginRight: '20px',width:'140px' }}
                      //onClick={signIn}
                      htmlType="submit"
                    >
                      Log In
                  
                  </Button>
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
