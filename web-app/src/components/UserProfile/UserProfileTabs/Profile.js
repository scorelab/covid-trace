import React from 'react'
import { Col, Typography, Divider, Row } from 'antd';
const { Text, Title } = Typography;

function Profile(props) {
    return (
        <div>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Profile Data</Title>
                                <Divider />
                                <Row>
                                    <Col xs={24} sm={4}>
                                        <Text strong>Name:</Text>
                                    </Col>
                                    <Col>
                                        <Text>Peter</Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"0.5em"}}>
                                    <Col xs={24} sm={4}>
                                        <Text strong>Contact No:</Text>
                                    </Col>
                                    <Col>
                                        <Text>0773454232</Text>
                                    </Col>
                                </Row>
                                <Row style={{marginTop:"0.5em"}}>
                                    <Col xs={24} sm={4}>
                                        <Text strong>Email:</Text>
                                    </Col>
                                    <Col>
                                        <Text>peterabc@gmail.com</Text>
                                    </Col>
                                </Row>
                                
        </div>
    )
}



export default Profile

