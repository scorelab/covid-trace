import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Layout, Row, Col, Typography, Avatar, Button, Space, Tooltip } from 'antd';
import firstImage from '../../assets/homePageFirstImage.svg'
import homePageSecondImage from '../../assets/homePageSecondImage.png'
import step1 from '../../assets/step1.svg'
import step2 from '../../assets/step2.svg'
import step3 from '../../assets/step3.svg'
import step4 from '../../assets/step4.svg'
import RegStep1 from '../../assets/RegStep1.png'
import RegStep2 from '../../assets/RegStep2.png'
import RegStep3 from '../../assets/RegStep3.png'
import RegStep4 from '../../assets/RegStep4.png'
import RegStep5 from '../../assets/RegStep5.png'
import RegStep6 from '../../assets/RegStep6.png'
import RegStep7 from '../../assets/RegStep7.png'
import family from '../../assets/family.png'
import homePageThirdImage from '../../assets/homePageThirdImage.png'
import githubLogo from '../../assets/githubLogo.png'
import scoreLabLogo from '../../assets/scoreLabLogo.png'
import enter from '../../assets/enter.png'
import { Link } from "react-router-dom";
import './homeStyles.css'
const { Header, Footer, Content } = Layout;
const { Title, Text } = Typography;

class HomePage extends Component {
  render() {
    return (
      <Layout style={{ minHeight: "100vh" }}>
        <Header className='header' >
          <Row style={{ width: '100%', padding: '0px 0px 10px 0px' }}>
            <Col xs={24} md={12} style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', justifyContent: 'start' }}>
              <Avatar size="large" src={enter} className='avator' style={{ marginBottom: '5px' }} />
              <Title level={3} style={{ cursor: 'pointer', marginTop: '10px' }}> SAFE IN</Title>
            </Col>
            <Col xs={24} md={12} style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
              <Link to='/signIn'>
                <Tooltip placement="bottom" title="Log into your account!">
                  <Button className="loginBtn" style = {{marginRight: '30px'}}>LOG IN</Button>
                </Tooltip>
              </Link>
              <Link to='/signUp'>
                <Tooltip placement="bottom" title="Create an account!">
                  <Button className="loginBtn" style = {{ backgroundColor:'rgba(29, 233, 110, 0.93)'}}>REGISTER</Button>
                </Tooltip>
              </Link>
            </Col>
          </Row>
        </Header>
        <Content style={{ background: 'white' }}>
          <Row style={{ marginTop: '70px' }}>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={firstImage} className="firstImage"></img>
            </Col>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', flexDirection: 'column', alignItems: 'center' }}>
              <Title level={2} style={{ textAlign: 'center', marginBottom: '-10px' }}>Stay Safe Without Being Traced</Title>
              <Title level={5} style={{ textAlign: 'center', maxWidth: '478px' }}>Join us today and help to stop the spread of COVID-19 through community-driven contact tracing</Title>
              <Row style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                <Space>
                  <Link to='/download'>
                    <Button className="downbtn">Download mobile app</Button>
                  </Link>
                </Space>
              </Row>
            </Col>
          </Row>
          <Row>
            <div className="whatIsSafeIn">
              <Title level={2} style={{ textAlign: 'center', marginTop: '20px' }}>What is Safe In ?  </Title>
              <Text style={{ textAlign: 'center', maxWidth: '1340px', fontSize: '26px', padding: '0px 20px 0px 20px' }}>Safe In is Voluntary Drive to Expose Potential Covid - 19 Spread.It helps contact tracers identify and get in touch quickly if you had possible exposure to Covid -19 </Text>
            </div>
          </Row>
          <Row className='center'>
            <Title level={2} style={{ textAlign: 'center', marginTop: '20px' }}>Why Use SafeIn?  </Title>
          </Row>
          <Row>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={homePageSecondImage} className="firstImage"></img>
            </Col>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', flexDirection: 'column', alignItems: 'center' }}>
              <div className="smallPoints">
                <Title level={3} className="smallPointTitle">*Protect Yourself  </Title>
                <Text className='smallPointContent'>Get notified quickly if you've been exposed to COVID-19, through close contact. Faster information means timely care for you.</Text>
              </div>
              <div className="smallPoints">
                <Title level={3} className="smallPointTitle">* Protect our loved ones  </Title>
                <Text className='smallPointContent'>Being notified earlier also means we can better protect those around us, reducing the spread of COVID-19.</Text>
              </div>
              <div className="smallPoints">
                <Title level={3} className="smallPointTitle">* Protect our community  </Title>
                <Text className='smallPointContent'>Ease the load on our frontliners, and support one another to live life normally and safely. Together, we can overcome COVID-19.</Text>
              </div>
            </Col>
          </Row>
          <Row className='center'>
            <Title level={2} style={{ textAlign: 'center', marginTop: '20px', marginBottom: '20px' }}>How To Register Your Company</Title>
          </Row>
          <Row className='center'>
            <Col xs={24} md={12} lg={8} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep1} className='RegStep1'></img>
            </Col>
            <Col xs={24} md={12} lg={8} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep2} className='commonStep'></img>
            </Col>
            <Col xs={24} md={12} lg={8} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep3} className='commonStep'></img>
            </Col>
          </Row>
          <Row className='center'>
            <Col xs={24} md={12} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep4} className='RegStep4'></img>
            </Col>
            <Col xs={24} md={12} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep5} className='commonStep'></img>
            </Col>
          </Row>
          <Row className='center' style={{ marginBottom: '20px' }}>
            <Col xs={24} md={12} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep6} className='RegStep6'></img>
            </Col>
            <Col xs={24} md={12} lg={12} style={{ display: 'flex', justifyContent: 'center' }}>
              <img src={RegStep7} className='RegStep6'></img>
            </Col>
          </Row>
          <Row className='center'>
            <Title level={2} style={{ textAlign: 'center', marginTop: '20px' }}>How Safe In Covid Tracker Works</Title>
          </Row>
          <Row>
            <Col xs={24} md={12} lg={6} style={{ display: 'flex', justifyContent: "center" }}>
              <div className='howSafe'>
                <img src={step1} style={{ maxWidth: '280px' }}></img>
              </div>
            </Col>
            <Col xs={24} md={12} lg={6} style={{ display: 'flex', justifyContent: "center" }}>
              <div className='howSafe'>
                <img src={step2} style={{ width: '160px', marginBottom: '80px' }}></img>
              </div>
            </Col>
            <Col xs={24} md={12} lg={6} style={{ display: 'flex', justifyContent: "center", alignItems: 'center', flexDirection: 'row' }}>
              <div className='howSafe'>
                <img src={step3} style={{ width: '300px' }} />
              </div>
            </Col>
            <Col xs={24} md={12} lg={6} style={{ display: 'flex', justifyContent: "center" }}>
              <div className='howSafe'>
                <img src={step4} style={{ width: '275px' }} />
              </div>
            </Col>
          </Row>
          <Row>
            <div className="benefits">
              <Row className="center">
                <Title level={3} style={{ textAlign: 'center' }}>How Safe In COVID Tracker Benefits You </Title>
              </Row>
              <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginTop: '20px' }}>
                <Text className='benefitsPoints'>Get Notified If You are exposed to persons tested positive for Covid 19</Text>
                <Text className='benefitsPoints'>Provide Your Details anywhere you visit effieciently and Contamination free</Text>
                <Text className='benefitsPoints'>Save your data only in the registration you can use these data anywhere you visit</Text>
                <Text className='benefitsPoints'>QR Option to instant check in and check out</Text>
              </div>
              <div>
              </div>
            </div>
          </Row>
          <Row className="center" style={{ marginTop: '30px' }}>
            <Title level={3} style={{ textAlign: 'center' }}>We have focused more about the Privacy and Security Of your Data</Title>
          </Row>
          <Row>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', flexDirection: 'column', alignItems: 'center' }}>
              <div className="smallPoints">
                <Title level={3} className="smallPointTitle">* Do not store your Data on Cloud  </Title>
                <Text className='smallPointContent'>We do not store your personal data on the cloud, Your personal data will be stored on your phone.</Text>
              </div>
              <div className="smallPoints">
                <Title level={3} className="smallPointTitle">* We get your data only you are positive</Title>
                <Text className='smallPointContent'>We do not store your personal data on the cloud, Your personal data will be stored on your phone.</Text>
              </div>
            </Col>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
              <img src={homePageThirdImage} style={{ minWidth: '100px', maxWidth: '300px' }} />
            </Col>
          </Row>
          <div className="Contribute">
            <Row className="center" style={{ marginTop: '20px', padding: '20px' }}>
              <Title level={3} style={{ textAlign: 'center' }}>Contribute</Title>
            </Row>
            <Row>
              <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }} >
                <Text style={{ fontSize: '20px', padding: '0px 10px 0px 10px', textAlign: "center", marginBottom: '10px' }}>Safe In is a open source project .You can contribute to this project via github</Text>
              </Col>
              <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
                <img src={githubLogo} width='200px' className="githublogo" />
              </Col>
            </Row>
          </div>
        </Content>
        <Footer className='footer'>
          <Row>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }} >
              <Text style={{ fontSize: '20px', padding: '0px 10px 10px 0px', textAlign: "center", marginBottom: '10px' }}>Project By</Text>
              <a href='https://scorelab.org/'>
                <img src={scoreLabLogo} width='200px' style={{ objectFit: 'contain', margin: '-5px 0px 20px 0px', cursor: 'pointer' }} />
              </a>

            </Col>
            <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }}>
              {/*     <Text style={{ fontSize: '20px', padding: '0px 10px 10px 0px', textAlign: "center", marginBottom: '10px' }}>Contact Us</Text> */}
              <Title level={4}>Contact Us</Title>
              <Text style={{ fontSize: '14px', marginTop: '-10px' }}>safe-in@scorelab.org</Text>
              <Title level={4}>Report Vulnerability</Title>
            </Col>
          </Row>
        </Footer>

      </Layout>
    )
  }
}

const mapStateToProps = ({ firebase }) => ({
  loggedIn: !!firebase.auth.uid,
});

export default connect(mapStateToProps)(HomePage);
