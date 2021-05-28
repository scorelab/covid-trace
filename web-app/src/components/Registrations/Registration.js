import React, { useState, useEffect } from 'react'
import { Layout, Card, Row, Col, Alert, Typography, Select } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import BusinessReg from './ReqTypeComponents/BusinessReg';
import BusReg from './ReqTypeComponents/BusReg';
import TrainReg from './ReqTypeComponents/TrainReg';
import VehicleReg from './ReqTypeComponents/VehicleReg';
import { connect } from 'react-redux'
import { Redirect, useParams } from 'react-router-dom';
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
const { Text } = Typography;
const { Content } = Layout;
const { Option } = Select;


function Registration(props) {

    let { UserName } = useParams();

    const [requestType, setRequestType] = useState('')

    const [state, setstate] = useState({
        orgList: [],
        usernames: [],
        org: UserName,
    })

    useEffect(() => {
        let tempOrgList = [];
        let tempusernames = [];
        (props.orgData && props.orgWithUserData) && (Object.keys(props.orgWithUserData).map(orgIdUsr => {
            if (props.orgWithUserData[orgIdUsr].phoneNumber === props.user.phoneNumber) {
                (Object.keys(props.orgData).map(orgId => {
                    if (props.orgData[orgId].UserName === props.orgWithUserData[orgIdUsr].org) {
                        tempOrgList.push({
                            ...props.orgData[orgId],
                            orgId
                        })
                        tempusernames.push(props.orgData[orgId].UserName);
                    }
                }))
            }

        })) 

        setstate({
            ...state,
            orgList: tempOrgList,
            usernames: tempusernames
        })
    }, [props.orgData, props.orgWithUserData])

  

    function handleChange(value) {
        setstate({
            ...state,
            org: value
        })
    }

    function changeRequestType(value) {
        setRequestType(value)
        console.log(value)
    }

    function onChange(e) {
        console.log(`checked = ${e.target.checked}`);
    }

    let component = null;
    let alert = null

    if ((state.org == '') && ((requestType=='Business')||(requestType=='Bus')||(requestType=='Vehicle')||(requestType=='Train'))) {
        alert =  <Alert message="Please select organisation first" type="warning" showIcon closable style={{with:'80%',marginTop:'20px'}} />
    
    } else {
        alert = null
        switch (requestType) {
            case "Business":
                component = <BusinessReg orgUserName={state.org} />;
                break;
            case "Bus":
                component = <BusReg orgUserName={state.org} />;
                break;
            case "Vehicle":
                component = <VehicleReg orgUserName={state.org} />;
                break;
            case "Train":
                component = <TrainReg orgUserName={state.org} />;
                break;
            default:
                component = <div></div>;
        }
    }

    if (props.user == null) return <Redirect to='signIn' />

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: '100vh' }}>
                <Navbar />
                {(UserName)?
                    (state.usernames && state.usernames.includes(UserName))?
                        <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                            <Card title="Requesting For QR Code" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "25px", minHeight: "185px", position: "sticky" }}>
                                <Row>
                                    <Col span={12}><Text>Select Owner</Text></Col>
                                    <Col span={12}>
                                    <Select defaultValue={UserName} placeholder="Owner" style={{ width: "100%" }} onChange={handleChange}>
                                        {
                                            state.orgList && state.orgList.map(i => {
                                                return (<Option value={i.UserName} key={i.orgId}>{i.Name} ({i.UserName})</Option>)
                                            })
                                        }
                                    </Select>
                                    </Col>
                                </Row>
                                <Row style={{ marginTop: "12px" }}>
                                    <Col span={12}><Text>Select Request Type</Text></Col>
                                    <Col span={12}>
                                        <Select placeholder="Request Type" style={{ width: "100%" }} onChange={changeRequestType}>
                                            <Option value="Business">Business</Option>
                                            <Option value="Bus">Bus</Option>
                                            <Option value="Vehicle">Vehicle</Option>
                                            <Option value="Train">Train</Option>
                                        </Select>
                                    </Col>
                                </Row>
                                {alert}
                            </Card>
                            {component}
                        </Content>
                    :<div
                    style={{
                      display: 'flex',
                      justifyContent: 'center',
                    }}
                  >
                    <p style={{marginBottom:'41%'}}>Organization username not valid!</p>
                  </div>
                :
                <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <Card title="Requesting For QR Code" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "25px", minHeight: "185px", position: "sticky" }}>
                        <Row>
                            <Col span={12}><Text>Select Owner</Text></Col>
                            <Col span={12}>
                                <Select placeholder="Owner" style={{ width: "100%" }} onChange={handleChange}>
                                    {
                                        state.orgList && state.orgList.map(i => {
                                            return (<Option value={i.UserName} key={i.orgId}>{i.Name} ({i.UserName})</Option>)
                                        })
                                    }
                            </Select>
                            </Col>
                        </Row>
                        <Row style={{ marginTop: "12px" }}>
                            <Col span={12}><Text>Select Request Type</Text></Col>
                            <Col span={12}>
                                <Select placeholder="Request Type" style={{ width: "100%" }} onChange={changeRequestType}>
                                    <Option value="Business">Business</Option>
                                    <Option value="Bus">Bus</Option>
                                    <Option value="Vehicle">Vehicle</Option>
                                    <Option value="Train">Train</Option>
                                </Select>
                            </Col>
                        </Row>
                    {alert}
                    </Card>
                    {component}
                </Content>        
                                }
                            
                <BottomFooter />
            </Layout>
        </div>
    )
}

const mapStateToProps = (state) => {
    console.log(state)
    return ({
        ...state,
        user: state.auth.auth.user,
        orgData: state.firestore.data.sc_org,
        orgWithUserData: state.firestore.data.sc_org_users,
    })
}

//export default connect(mapStateToProps)(Registration)

export default compose(
    firestoreConnect([
        { collection: 'sc_org' },
        { collection: 'sc_org_users' }
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(Registration)
