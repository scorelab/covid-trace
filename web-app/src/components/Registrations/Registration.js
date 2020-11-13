import React, { useState } from 'react'
import { Layout, Card, Row, Col, Input, Typography, Select } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import BusinessReg from './ReqTypeComponents/BusinessReg';
import BusReg from './ReqTypeComponents/BusReg';
import TrainReg from './ReqTypeComponents/TrainReg';
import VehicleReg from './ReqTypeComponents/VehicleReg';
const { Text } = Typography;
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

    let component = null;

    switch (requestType) {
        case "Business":
            component = <BusinessReg />;
            break;
        case "Bus":
            component = <BusReg />;
            break;
        case "Vehicle":
            component = <VehicleReg />;
            break;
        case "Train":
            component = <TrainReg />;
            break;
        default:
            component = <div></div>;
    }
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: '100vh' }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                    <Card title="Requesting For QR Code" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "25px",  minHeight: "185px", position: "sticky" }}>
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
                                    <Option value="Vehicle">Vehicle</Option>
                                    <Option value="Train">Train</Option>
                                </Select>
                            </Col>
                        </Row>
                    </Card>
                    {component}
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}


export default Registration

