import React, { useState } from 'react'
import { Layout, Card, Tabs} from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import Profile from './UserProfileTabs/Profile';
const { TabPane } = Tabs;
const { Content } = Layout;


function UserProfile(props) {
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <Card style={{ width: '950px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", height: "71vh", marginBottom:"80px", position: "sticky" }}>
                        <Tabs tabPosition='left'>
                            <TabPane tab="Profile" key="1">
                                <Profile />
                            </TabPane>
                            <TabPane tab="Tab 2" key="2">
                                Content of Tab 2
                            </TabPane>
                            <TabPane tab="Tab 3" key="3">
                                Content of Tab 3
                            </TabPane>
                        </Tabs>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}


export default UserProfile

