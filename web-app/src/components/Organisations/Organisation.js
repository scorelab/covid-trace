import React, { useEffect, useState } from 'react'
import { Layout, Card, Button, Row, Col, Spin,Typography } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
const { Content } = Layout;
const { Text, Link } = Typography

function Organisation(props) {


    const [state, setstate] = useState({
        orgList: []
    })

    useEffect(() => {
        let tempOrgList = [];
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

        // console.log(tempOrgList)
        setstate({
            orgList: tempOrgList
        })
    }, [props.orgData, props.orgWithUserData])

    if (props.user == null) return <Redirect to='signIn' />

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Organisations" style={{ width: '1150px', boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "6.9vh", overflow: "auto", minHeight: "64vh", marginBottom: "80px", position: "sticky" }}>
                        <Row>
                            {
                                state.orgList ? state.orgList.map((org) => {
                                    return (
                                        <Col sm={24} md={12} lg={12} xl={8} justify="space-around" align="middle" key={org.orgId}>
                                            <Card size="small" title={org.Name} style={{ width: 300, boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginBottom: "30px", borderRadius: "8px" }}>
                                    <Row justify={"center"}>
                                    <Text strong>UserName : </Text>
                                    <Text> {org.UserName}</Text>
                                    </Row>
                                    <Row justify={"center"} style={{marginBottom:'20px',marginTop:'10px'}}>
                                    <Text strong>WebSite : </Text>
                                    <Text> {org.WebSite}</Text>
                                    </Row>
                                                <Button type="primary">Locations</Button>
                                            </Card>
                                        </Col>
                                    )
                                })
                                    :
                                    <Row style={{ height: '59vh', width: '1150px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                        <Spin size="large" />
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
    console.log(state.firestore)
    return ({
        ...state,
        user: state.auth.auth.user,
        orgData: state.firestore.data.sc_org,
        orgWithUserData: state.firestore.data.sc_org_users,
    })
}

export default compose(
    firestoreConnect([
        { collection: 'sc_org' },
        { collection: 'sc_org_users' }
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(Organisation)

//export default connect(mapStateToProps)(Organisation)

