import React from 'react'
import { Layout, Card, Input, Button } from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
const { Content } = Layout;

function AddOrganisation(props) {
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Add New Organisation" style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "131px", height: '290px' }}>
                        <div style={{ margin: "5px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>
                            
                            <Input defaultValue="" placeholder="Organisation Name" style={{ marginBottom: '10px' }} />
                            <Input defaultValue="" placeholder="Organisation UserName" style={{ marginBottom: '10px' }} />
                            <Input defaultValue="" placeholder="Website URL" style={{ marginBottom: '10px' }} />

                            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: "center", paddingTop: '10px' }}>
                                <Button type="primary" style={{width:"150px"}}>Add</Button>
                            </div>

                        </div>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}


export default AddOrganisation

