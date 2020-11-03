import React from 'react'
import { Layout, Card, Input, Button } from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
const {  Content } = Layout;


function SignIn(props) {
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Welcome" style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "131px", height: '250px' }}>
                        <div style={{ margin: "5px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>
                            <Input addonBefore="+94" defaultValue="" placeholder="Contact No" style={{ marginBottom: '10px' }} type="number" />
                            <Input defaultValue="" placeholder="Password" type="password" style={{ marginBottom: '30px' }} />
                            <Button type="primary" style={{ marginLeft: "130px", marginRight: '130px' }}>Sign In</Button>
                        </div>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}

export default SignIn

