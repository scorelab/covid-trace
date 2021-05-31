import { Button, Card, Input, Layout,Spin,Alert,Row, Typography } from 'antd';
import React, { useEffect, useState } from 'react';
import { connect, connectAdvanced } from 'react-redux';
import * as actions from '../../store/actions';
import BottomFooter from '../UiElements/BottomFooter';
import Navbar from '../UiElements/Navbar/Navbar';
import { useHistory } from "react-router-dom";
import {Link} from "react-router-dom";

const { Content } = Layout;
const { Title } = Typography;

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
        <Navbar dimensions={props.dimensions} direct="SignUp" dir_name="Register"/>
        <Content
          style={{
            padding: '0 50px',
            display: 'flex',
            justifyContent: 'center',
          }}
        >
          <Card
            title={<Title level={5}>Welcome to Safe In!</Title>} 
            style={{
              width: 475,
              boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)',
              marginTop: '50px',
              marginBottom: '10px',
              minheight: '360px',
              maxHeight: '400px',
              textAlign: 'center'
            }}
          >   
              <form onSubmit={signIn}>
                <Row>
                  Phone Number
                  <Input
                    aria-label={"Enter your phone number in the +94 format without the +94 part"}
                    addonBefore="+94"
                    defaultValue=""
                    placeholder="Phone Number"
                    type = "tel"
                    maxLength = "9"
                    style={{ marginBottom: '10px', marginTop: '5px' }}
                    onChange={onChangePhoneNumber}
                    value={contactNo}
                    required
                  />
                </Row>
                <Row>
                  Password
                  <Input
                    aria-label="Enter your password"
                    defaultValue=""
                    placeholder="Password"
                    type="password"
                    style={{ marginBottom: '10px', marginTop: '5px' }}
                    onChange={onChangePassword}
                    value={password}
                    required
                  />
                </Row>
                <Row style={{ display: 'flex', justifyContent: 'center', paddingBottom: '10px' }}>
                  <Button
                      type="primary"
                      style={{ marginRight: '20px',width:'140px' }}
                      htmlType="submit"
                      data-toggle="tooltip" data-placement="top" title="Login to Safe In"
                    >
                      Log In
                  </Button>
                </Row>
                <Row style={{ display: 'flex', justifyContent: 'center' }}>
                  <Link to="/signUp"
                    aria-label="If you are new to Safe In, click here to register" data-toggle="tooltip" data-placement="top" title="Register with Safe In">
                    New to Safe In? Click here to Register
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
