import React, { useEffect, useState } from 'react'
import { Layout, Card, Button, Row, Col, Spin, Typography } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
import { Link, useHistory } from "react-router-dom";
const { Content } = Layout;
const { Text } = Typography

function Organisation(props) {

    let history = useHistory();

    const [state, setstate] = useState({
        orgList: [],
        orgList_withLoc: []
    })

    useEffect(() => {
        let tempOrgList = [];
        let temporgList_withLoc = [];
        (props.orgData && props.orgWithUserData) && (Object.keys(props.orgWithUserData).map(orgIdUsr => {
            if (props.orgWithUserData[orgIdUsr].phoneNumber === props.user.phoneNumber) {
                (Object.keys(props.orgData).map(orgId => {
                    if (props.orgData[orgId].UserName === props.orgWithUserData[orgIdUsr].org) {
                        tempOrgList.push({
                            ...props.orgData[orgId],
                            orgId
                        })
                    }
                }))
            }
        })) 
        && (props.locationReqestData) && (Object.keys(props.locationReqestData).map(entryId => {
             temporgList_withLoc.push(props.locationReqestData[entryId].org)
        }))
        console.log(state.orgList)
        setstate({
            orgList: tempOrgList,
            orgList_withLoc: temporgList_withLoc
        })
    }, [props.orgData, props.orgWithUserData, props.locationReqestData])

    function goToLocation(val){
        history.push(`/locations/${val}`);
    }

    function goToOrg(val){
        history.push(`/registration/${val}`);
    }

    // if (props.user == null) return <Redirect to='signIn' />

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Organizations" style={{ width: '1150px', boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "6.9vh", overflow: "auto", minHeight: "627px", marginBottom: "80px", position: "sticky" }}>
                        <Row>
                            {
                                (state.orgList.length) ? 
                                    (props.orgData && props.orgWithUserData) ? 
                                    state.orgList.map((org) => {
                                        return (
                                            <Col sm={24} md={12} lg={12} xl={8} justify="space-around" align="middle" key={org.orgId}>
                                                <Card size="small" title={org.Name} style={{ width: 300, boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginBottom: "30px", borderRadius: "8px" }}>
                                                    <Row justify={"center"}>
                                                        <Text strong>UserName : </Text>
                                                        <Text> {org.UserName}</Text>
                                                    </Row>
                                                    <Row justify={"center"} style={{ marginBottom: '20px', marginTop: '10px' }}>
                                                        <Text strong>WebSite : </Text>
                                                        <Text> {org.WebSite}</Text>
                                                    </Row>
                                                    {(state.orgList_withLoc.includes(org.UserName)) ?
                                                    (
                                                    <div>
                                                        <Button type="primary" onClick={() => goToLocation(org.UserName)}>Locations</Button>
                                                        <br></br>
                                                        <Button type="primary" onClick={() => goToOrg(org.UserName)} style={{ marginTop: '10px' }}>Add Your Location</Button>
                                                    </div>
                                                    ):
                                                    (<div>
                                                        <p>Go ahead and add locations to <b>{org.Name}</b></p>
                                                        <Button type="primary" onClick={() => goToOrg(org.UserName)}>Add Your Location</Button>
                                                    </div>)
                                                    }
                                                    
                                                </Card>
                                            </Col>
                                        )
                                })
                                :
                                <Row style={{ height: '59vh', width: '1150px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                    <Spin size="large" />
                                </Row>   
                                :
                                <Row style={{ height: '59vh', width: '1150px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                        <Col sm={24} md={12} lg={12} xl={8} justify="space-around" align="middle">
                                            <Card size="small" title="Welcome !" style={{ width: 300, boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginBottom: "30px", borderRadius: "8px" }}>
                                                <Row justify={"center"}>
                                                    <Text strong>Get started by adding an organization</Text>
                                                    <Text style={{marginTop: "10px"}}>
                                                        <Link to="/addOrganisation">
                                                            <Button type="primary" >Add Organizations</Button>
                                                        </Link>
                                                    </Text>
                                                </Row>
                                            </Card>
                                        </Col>
                                </Row>
                                 

                            }

                        </Row>
                    </Card>

                </Content>
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
        locationReqestData: state.firestore.data.sc_request_status
    })
}

export default compose(
    firestoreConnect([
        { collection: 'sc_org' },
        { collection: 'sc_org_users' },
        { collection: 'sc_request_status' }
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(Organisation)

//export default connect(mapStateToProps)(Organisation)

