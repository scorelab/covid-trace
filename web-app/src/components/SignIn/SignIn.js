import { Button, Card, Input, Layout,Spin } from 'antd';
import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
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
      history.push("/organisations");
    }
  }, [props.user])

  function onChangePhoneNumber(e) {
    setContactNo(e.target.value);
  }
  function onChangePassword(e) {
    setPassword(e.target.value);
  }

  const signIn = () => {
    const phoneNumber = "+94".concat(contactNo)
    props.logIn({ phoneNumber, password });
  };

  console.log(props.error);

  return (
    <div style={{ background: '#F2F2F2' }}>
      <Layout style={{ minHeight: '100vh' }}>
        <Navbar />
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
              height: '275px',
            }}
          >
            <div
              style={{
                margin: '10px 0px 52px',
                display: 'flex',
                justifyContent: 'center',
                flexDirection: 'column',
              }}
            >
              <Input
                addonBefore="+94"
                defaultValue=""
                placeholder="Contact No"
                style={{ marginBottom: '30px' }}
                onChange={onChangePhoneNumber}
                value={contactNo}
              />
              <Input
                defaultValue=""
                placeholder="Password"
                type="password"
                style={{ marginBottom: '30px' }}
                onChange={onChangePassword}
                value={password}
              />
              <div style={{ display: 'flex', justifyContent: 'center' }}>
                <Button
                  type="primary"
                  style={{ marginRight: '20px',width:'140px' }}
                  onClick={signIn}
                >
                  Sign In
              
              </Button>
              <Link to="/signUp">
                <Button
                  type="primary"
                  style={{width:'140px' }}
                >
                  Sign Up
              </Button>
              </Link>
              </div>

              {props.loading ?
              <div style={{ display: 'flex', justifyContent: 'flex-start' }}>
               <Spin />
               </div>
               : null}
              {props.error ? props.error : null}

            </div>
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
});

const mapDispatchToProps = {
  logIn: actions.signIn,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);
