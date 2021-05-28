import React, { Component } from 'react';
import { Layout, Row, Col, Typography, Avatar, Button, Tooltip } from 'antd';
import scoreLabLogo from '../../assets/scoreLabLogo.png'
import enter from '../../assets/enter.png'
import { Link } from "react-router-dom";
import downloadPageImage from '../../assets/downloadPageImage.png'
import styles from './downloadPage.module.css';
import { AndroidOutlined } from '@ant-design/icons';
const { Header, Footer, Sider, Content } = Layout;
const { Title, Text } = Typography;

function DownloadPage(props) {
    return (
        <Layout style={{ minHeight: "100vh" }}>
            <Header className={styles.header} >
                <Row style={{ width: '100%', padding: '0px 0px 10px 0px' }}>
                    <Col xs={24} md={12} style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', justifyContent: 'start' }}>
                        <Link to='/'>
                            <Avatar size="large" src={enter} className={styles.avator} style={{ marginBottom: '5px' }} />
                        </Link>
                        <Link to='/'>
                            <Title level={3} style={{ cursor: 'pointer', marginTop: '10px' }}> SAFE IN</Title>
                        </Link>
                    </Col>
                    <Col xs={24} md={12} style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
                        <Link to='/signUp'>
                            <Tooltip placement="bottom" title="Create an account!">
                                <Button className={styles.loginBtn}>SIGN UP</Button>
                            </Tooltip>
                        </Link>
                        &nbsp;
                        <Link to='/signIn'>
                            <Tooltip placement="bottom" title="Log into your account!">
                                <Button className="loginBtn">SIGN IN</Button>
                            </Tooltip>
                        </Link>
                    </Col>
                </Row>
            </Header>
            <Content style={{ background: 'white' }}>
                <Row justify='center'>
                    <Title level={2} style={{ textAlign: 'center', margin: '30px 0px -20px 0px' }} className={styles.info}>Download Safe In for Android Here</Title>
                </Row>
                <Row style={{ marginTop: '70px' }} justify="center" className={styles.background}>
                    <Col xs={24} md={24} lg={6} style={{ display: 'flex', justifyContent: 'center' }}>
                        <img src={downloadPageImage} className={styles.downloadPageImage}></img>
                    </Col>
                    <Col xs={24} md={24} lg={9} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                        <Title level={5} style={{ textAlign: 'center', maxWidth: '700px', marginTop: '60px', marginBottom: '30px' }} className={styles.info}>Google doesn’t allow  volunetry driven contract tracing app in the Play
                        Store yet, but you can download Safe In directly from us.
 Don’t worry, it’s completely secure and up to Google's high standards.</Title>
                        <Row justify="center" align="top" style={{ flexDirection: 'column', alignItems: 'center' }}>
                            <a href="https://drive.google.com/u/1/uc?id=1ofBKm0aIo8Wtdw7xSunMYi3nMlVnW2Od&export=download">
                                <Button className={styles.downloadbtn} icon={<AndroidOutlined />}>Download Now</Button>
                            </a>
                            <Row justify='center'>
                                <Text className={styles.hashcodefont} >
                                    SHA256 SIGNATURE:
                                    </Text>
                                <Text className={styles.hashcodefont}>
                                    2d7acf3e0b820ea834663884d2522ea86f5e0cbac8d18a8871d3d1301d9f2038
                                    </Text>
                            </Row>

                        </Row>
                    </Col>
                </Row>
            </Content>
            <Footer className={styles.footer}>
                <Row>
                    <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }} >
                        <Text style={{ fontSize: '20px', padding: '0px 10px 10px 0px', textAlign: "center", marginBottom: '10px' }}>Project By</Text>
                        <a href='https://scorelab.org/'>
                            <img src={scoreLabLogo} width='200px' style={{ objectFit: 'contain', margin: '-5px 0px 20px 0px', cursor: 'pointer' }} />
                        </a>

                    </Col>
                    <Col xs={24} md={24} lg={12} style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }}>
                        <Title level={4}>Contact Us</Title>
                        <Text style={{ fontSize: '14px', marginTop: '-10px' }}>safe-in@scorelab.org</Text>
                        <Title level={4}>Report Vulnerability</Title>
                    </Col>
                </Row>
            </Footer>

        </Layout>
    )
}


export default DownloadPage

