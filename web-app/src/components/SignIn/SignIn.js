import { Button, Card, Input, Layout } from 'antd';
import React, { useState } from 'react';
import { connect } from 'react-redux';
import * as actions from '../../store/actions';
import BottomFooter from '../UiElements/BottomFooter';
import Navbar from '../UiElements/Navbar';

const { Content } = Layout;

function SignIn(props) {

  const [phoneNumber, setPhoneNumber] = useState('');
  const [password, setPassword] = useState('');

  function onChangePhoneNumber(e) {
    setPhoneNumber(e.target.value);
  }
  function onChangePassword(e) {
    setPassword(e.target.value);
  }

  const signIn = () => {
    props.logIn({ phoneNumber, password });
  };

  console.log(props.error);

  return (
    <div style={{ background: '#F2F2F2' }}>
      <Layout style={{ height: '100vh' }}>
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
              height: '300px',
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
                type="number"
                onChange={onChangePhoneNumber}
                value={phoneNumber}
              />
              <Input
                defaultValue=""
                placeholder="Password"
                type="password"
                style={{ marginBottom: '30px' }}
                onChange={onChangePassword}
                value={password}
              />
              <Button
                type="primary"
                style={{ marginLeft: '130px', marginRight: '130px' }}
                onClick={signIn}
              >
                Sign In
              </Button>
              {props.loading ? 'siginin..' : null}
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
});

const mapDispatchToProps = {
  logIn: actions.signIn,
};

export default connect(mapStateToProps, mapDispatchToProps)(SignIn);
