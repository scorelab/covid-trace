import React, { useState } from 'react'
import { Layout, Card, Divider, Row, Col, Input, Typography, Select, Checkbox, Button } from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
const { Text, Link } = Typography;
const { Content } = Layout;
const { Option } = Select;

function BusReg(props) {

    function onChange(e) {
        console.log(`checked = ${e.target.checked}`);
    }

    function handleChange(value) {
        console.log(`selected ${value}`);
    }

    return (
        <div>
           <Card title="Fill these Details" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", height: "260px", position: "sticky" }}>
                        <Row justify="space-between" >
                            <Col sm={24} md={13}  >
                                <Input placeholder="Bus No"  />
                            </Col>
                            <Col sm={24} md={1}  >
                            </Col>
                            <Col sm={24} md={10} >
                                <Input placeholder="Bus Route No" />
                            </Col>
                        </Row>
                        <Row justify="space-between" >
                            <Col sm={24} md={13}  >
                                <Input placeholder="Name" style={{ marginTop: '12px' }} />
                            </Col>
                            <Col sm={24} md={1}  >
                            </Col>
                            <Col sm={24} md={10} >
                            <Input addonBefore="+94" placeholder="Contact No" style={{ marginTop: '12px' }} />
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
        </div>
    )
}

export default BusReg

