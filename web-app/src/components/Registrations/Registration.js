import React, { useState } from 'react'
import { Layout, Card, Divider, Row, Col, Input, Typography, Select, Checkbox, Button } from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
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
                    

                     <Card title="Fill these Details" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", height: "580px", position: "sticky" }}>
                        <Row>
                            <Col span={24}>
                                <Input placeholder="Name" />
                            </Col>
                        </Row>
                        <Row justify="space-between" >
                            <Col sm={24} md={13}  >
                                <Input addonBefore="+94"  placeholder="Contact No" style={{marginTop:'12px'}} />
                            </Col>
                            <Col sm={24} md={1}  >
                            </Col>
                            <Col sm={24} md={10} >
                            <Select placeholder="Premise Type" style={{ width: "100%", marginTop: '12px' }} onChange={handleChange}>
                                    <Option value="jack">School</Option>
                                    <Option value="lucy">Super Market</Option>
                                    <Option value="Yiminghe">Grocery</Option>
                                    <Option value="Yiminghe">Temple</Option>
                                </Select>
                            </Col>
                        </Row>
                        <Divider orientation="left">Location</Divider>
                        <Row justify="space-between" >
                            <Col sm={24} md={7}  >
                                <Select placeholder="Province" style={{ width: "100%", marginTop: '12px' }} onChange={handleChange}>
                                    <Option value="jack">Jack</Option>
                                    <Option value="lucy">Lucy</Option>
                                    <Option value="Yiminghe">yiminghe</Option>
                                </Select>
                            </Col>
                            <Col sm={24} md={1}  >
                            </Col>
                            <Col sm={24} md={7} >
                                <Select placeholder="District" style={{ width: "100%", marginTop: '12px' }} onChange={handleChange}>
                                    <Option value="jack">Jack</Option>
                                    <Option value="lucy">Lucy</Option>
                                    <Option value="Yiminghe">yiminghe</Option>
                                </Select>
                            </Col>
                            <Col sm={24} md={1}></Col>
                            <Col sm={24} md={7} >
                                <Select placeholder="City" style={{ width: "100%", marginTop: '12px' }} onChange={handleChange}>
                                    <Option value="jack">Jack</Option>
                                    <Option value="lucy">Lucy</Option>
                                    <Option value="Yiminghe">yiminghe</Option>
                                </Select>
                            </Col>
                        </Row>
                        <Row justify="space-between" >
                            <Col sm={24} md={7}  >
                                <Input placeholder="Postal Code" style={{ marginTop: "12px" }} />
                            </Col>
                            <Col sm={24} md={1}  >
                            </Col>
                            <Col sm={24} md={7} >
                                <Input placeholder="Floor No" style={{ marginTop: "12px" }} />
                            </Col>
                            <Col sm={24} md={1}></Col>
                            <Col sm={24} md={7} >
                                <Input placeholder="Unit No" style={{ marginTop: "12px" }} />
                            </Col>
                        </Row>
                        <Row>
                            <Col span={24}>
                                <Input placeholder="Address" style={{ marginTop: "12px" }} />
                            </Col>
                        </Row>
                        <Divider orientation="left"></Divider>
                        <Row>
                            <Col span={24}>
                                <Input placeholder="FB Page URL" />
                            </Col>
                        </Row>
                        <Row>
                            <Col span={24}>
                                <Input placeholder="Google Place" style={{ marginTop: "10px" }} />
                            </Col>
                        </Row>
                        <Row justify="space-between" align="middle">
                            <Col sm={24} md={10}  >
                                <Checkbox onChange={onChange} style={{ marginTop: "35px" }} >Confirm Your Details Is Correct</Checkbox>
                            </Col>
                            <Col sm={24} md={10}   >
                                <Button type="primary" style={{ marginTop: "35px", width: "100%" }} >Submit</Button>
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

