import React, { useState } from 'react'
import { Layout, Card, Tabs} from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import Profile from './UserProfileTabs/Profile';
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';
const { TabPane } = Tabs;
const { Content } = Layout;


function UserProfile(props) {

    if(props.user==null)return <Redirect to='signIn' />

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar dimensions={props.dimensions} />
                <Content style={{ padding: '0 20px', display: 'flex', justifyContent: 'center' }}>
                    <Card style={{ width: '950px', minHeight: 'auto', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", marginBottom:"80px", position: "sticky" }}>
                        <Tabs tabPosition={ props.dimensions.width > '576' ? 'left' : 'top'}>
                            <TabPane tab="Profile" key="1" data-toggle="tooltip" data-placement="top" title="Go to Profile">
                                <Profile />
                            </TabPane>
                            {/* <TabPane tab="Tab 2" key="2" data-toggle="tooltip" data-placement="top" title="Go to Tab 2">
                                Content of Tab 2
                            </TabPane>
                            <TabPane tab="Tab 3" key="3" data-toggle="tooltip" data-placement="top" title="Go to Tab 3">
                                Content of Tab 3
                            </TabPane> */}
                        </Tabs>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}

const mapStateToProps = (state) => {
    //console.log(state)
    return ({
        ...state,
        user:state.auth.auth.user
    })
}


export default connect(mapStateToProps)(UserProfile)

