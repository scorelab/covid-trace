import React from 'react'
import { Layout, Card, Input, Button } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
const { Content } = Layout;

function SignUp(props) {
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Welcome" style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "131px", height: '330px' }}>
                        <div style={{ margin: "10px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>
                            <Input addonBefore="+94" defaultValue="" placeholder="Contact No" style={{ marginBottom: '10px' }} type="number" />
                            <Input defaultValue="" placeholder="NIC" addonAfter="V" style={{ marginBottom: '10px' }} type="text" />
                            <Input defaultValue="" placeholder="Password" type="password" style={{ marginBottom: '10px' }} />
                            <Input defaultValue="" placeholder="Reenter Password" type="password" style={{ marginBottom: '10px' }} />
       
                            <div style={{display:'flex',flexDirection:'row',justifyContent:"center",paddingTop:'20px'}}> 
                                <Button type="primary" style={{width:'150px'}} >Sign Up</Button>
                            </div>

                        </div>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}

export default SignUp

