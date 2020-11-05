import React, { useState } from 'react'
import { Layout, Card, Divider, Row, Col, Input, Typography, Select, Checkbox, Button } from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import BusinessReg from './BusinessReg';
import BusReg from './BusReg';
import ThreeWheelReg from './ThreeWheelReg';
import TrainReg from './TrainReg';
const { Text, Link } = Typography;
const { Content } = Layout;
const { Option } = Select;

function Registration(props) {

    const [requestType, setRequestType] = useState('')

    function handleChange(value) {
        console.log(`selected ${value}`);
    }
    
    function changeRequestType(value) {
        setRequestType(value)
        console.log(value)
    }

    function onChange(e) {
        console.log(`checked = ${e.target.checked}`);
    }

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <Card title="Requesting For QR Code" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "25px", overflow: "auto", height: "185px", position: "sticky" }}>
                        <Row>
                            <Col span={12}><Text>Select Owner</Text></Col>
                            <Col span={12}><Input placeholder="Owner" /></Col>
                        </Row>
                        <Row style={{ marginTop: "12px" }}>
                            <Col span={12}><Text>Select Request Type</Text></Col>
                            <Col span={12}>
                                <Select placeholder="Request Type" style={{ width: "100%" }} onChange={changeRequestType}>
                                    <Option value="Business">Business</Option>
                                    <Option value="Bus">Bus</Option>
                                    <Option value="Three Wheel">Three Wheel</Option>
                                    <Option value="Train">Train</Option>
                                </Select>
                            </Col>
                        </Row>
                    </Card>


                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}


export default Registration

