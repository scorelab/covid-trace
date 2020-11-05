import React, { useState } from 'react'
import { Col, Button, Typography, Divider, Row } from 'antd';
import { CopyTwoTone } from '@ant-design/icons';
const { Text, Title } = Typography;

function CompanyInfoDetails(props) {
    return (
        <div>
            <Title level={5} style={{ textAlign: "center", marginBottom: "-15px" }}>Details</Title>
                                <Divider />

                                <Row>
                                    <Col span={2}>
                                        <Text strong>Name:</Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text>ABC Company</Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"0.5em"}}>
                                    <Col span={3}>
                                        <Text strong>Contact No:</Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text>0773454232</Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"0.5em"}}>
                                    <Col span={4}>
                                        <Text strong>Premise Type:</Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text>Grocery</Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"0.5em"}}>
                                    <Text strong>Location</Text>
                                </Row>
                                <Row justify="space-around" style={{marginTop:"1em"}}>
                                    <Col span={5}>
                                        <Text strong style={{ marginRight: "1em" }}> Province: </Text>
                                        <Text> Western </Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text strong style={{ marginRight: "1em" }}> District: </Text>
                                        <Text> Colombo </Text>
                                    </Col>
                                    <Col span={6}>
                                        <Text strong style={{ marginRight: "1em" }}> City: </Text>
                                        <Text> Bambalapitiya </Text>
                                    </Col>
                                </Row>
                                <Row justify="space-around" style={{marginTop:"0.5em"}}>
                                    <Col span={5}>
                                        <Text strong style={{ marginRight: "1em" }}> Postal Code: </Text>
                                        <Text> 2345 </Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text strong style={{ marginRight: "1em" }}> Floor No: </Text>
                                        <Text> 2 </Text>
                                    </Col>
                                    <Col span={6}>
                                        <Text strong style={{ marginRight: "1em" }}> Unit No: </Text>
                                        <Text> 20 </Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"1em"}}>
                                    <Col span={2}>
                                        <Text strong>fb URL:</Text>
                                    </Col>
                                    <Col span={18}>
                                        <Text>https://www.facebook.com/fsdtefdget</Text>
                                    </Col>
                                </Row>
                                <Divider />
                                <Title level={5} style={{ textAlign: "center", marginTop: "-15px" }}>Get QR Code</Title>
                                <Row justify="space-around" style={{marginTop:"1em"}}>
                                    <Col sm={24} md={8}>
                                        <Text strong>Sinhala QR Code</Text>
                                    </Col>
                                    <Col sm={24} md={7} >
                                        <Text type="secondary">http://traceapp.com/qWefeIG</Text>
                                    </Col>
                                    <Col sm={24} md={1}>
                                        <CopyTwoTone />
                                    </Col>
                                    <Col sm={24} md={6}>
                                        <Button type="primary">Download QR</Button>
                                    </Col>
                                </Row>
                                <Row justify="space-around" style={{marginTop:"1em"}}>
                                    <Col sm={24} md={8}>
                                        <Text strong>English QR Code</Text>
                                    </Col>
                                    <Col sm={24} md={7}>
                                        <Text type="secondary">http://traceapp.com/eRjUklt</Text>
                                    </Col>
                                    <Col sm={24} md={1}>
                                        <CopyTwoTone />
                                    </Col>
                                    <Col sm={24} md={6}>
                                        <Button type="primary">Download QR</Button>
                                    </Col>
                                </Row>
                                <Row justify="space-around" style={{marginTop:"1em"}}>
                                    <Col sm={24} md={8}>
                                        <Text strong>English QR Code</Text>
                                    </Col>
                                    <Col sm={24} md={7}>
                                        <Text type="secondary">http://traceapp.com/lIofRe</Text>
                                    </Col>
                                    <Col sm={24} md={1}>
                                        <CopyTwoTone />
                                    </Col>
                                    <Col sm={24} md={6}>
                                        <Button type="primary">Download QR</Button>
                                    </Col>
                                </Row>
        </div>
    )
}


export default CompanyInfoDetails

