import React, { useEffect, useState } from 'react'
import { Layout, Card, Button, Row, Col } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { Redirect } from 'react-router-dom';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
const { Content } = Layout;

function Organisation(props) {


    /*  const [state, setstate] = useState({
         orgList: []
     }) */

    /* useEffect(() => {
        console.log(props.orgData)
        
    }, [props.orgData]) */

    if (props.user == null) return <Redirect to='signIn' />

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Organisations" style={{ width: '1150px', boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "6.9vh", overflow: "auto", minHeight: "64vh", marginBottom: "80px", position: "sticky" }}>
                        <Row>

                            {
                                props.orgData && Object.keys(props.orgData).map(orgId => {
                                    return (
                                        <Col sm={24} md={12} lg={12} xl={8} justify="space-around" align="middle" key={orgId}>
                                            <Card size="small" title="Organisation A" style={{ width: 300, boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginBottom: "30px", borderRadius: "8px" }}>
                                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ullamcorper </p>
                                                <Button type="primary">Locations</Button>
                                            </Card>
                                        </Col>
                                    )
                                })


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
    console.log(state.firestore.data.sc_org)
    return ({
        ...state,
        user: state.auth.auth.user,
        orgData: state.firestore.data.sc_org
    })
}

export default compose(
    firestoreConnect([
        { collection: 'sc_org' }
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(Organisation)

//export default connect(mapStateToProps)(Organisation)

