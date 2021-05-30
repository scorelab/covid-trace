import React from 'react'
import { Col, Typography, Divider, Row } from 'antd';
const { Text, Title } = Typography;

function Profile(props) {
    return (
        <div>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Profile Data</Title>
                                <Divider />
                                <Row>
                                    <Col span={2}>
                                        <Text strong>Name:</Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text>Peter</Text>
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
                                    <Col span={2}>
                                        <Text strong>Email:</Text>
                                    </Col>
                                    <Col span={5}>
                                        <Text>peterabc@gmail.com</Text>
                                    </Col>
                                </Row>
                                
        </div>
    )
}



export default Profile

