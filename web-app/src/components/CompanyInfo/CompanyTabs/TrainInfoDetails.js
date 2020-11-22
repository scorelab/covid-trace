import React, { useEffect, useState } from 'react'
import { Col, Button, Typography, Divider, Row } from 'antd';
import { CopyTwoTone } from '@ant-design/icons';
import { useHistory } from 'react-router-dom';
const { Text, Title } = Typography;

function TrainInfoDetails(props) {

    const [trainDetails, setTrainDetails] = useState({
        carriage_no: "",
        key: "",
        location: "",
        location_id: "",
        location_type: "",
        org: "",
        train_name: "",
        train_no: ""
    })

    let history = useHistory();

    function GoToQRPage(lang) {
        history.push({
            pathname: `/qrpage/${trainDetails.location}`,
            state: { ...trainDetails }
        })
    }

    useEffect(() => {
        console.log(props.companyDetails)
        props.data && setTrainDetails({
            ...props.data
        })
    }, [props.companyDetails])

    return (
        <div>
            <Title level={5} style={{ textAlign: "center", marginBottom: "-15px" }}>Train Details</Title>
            <Divider />

            <Row>
                <Col span={3}>
                    <Text strong>Train Name :</Text>
                </Col>
                <Col span={5}>
                    <Text>{trainDetails.train_name}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={2}>
                    <Text strong>Train No :</Text>
                </Col>
                <Col span={5}>
                    <Text style={{marginLeft:'10px'}}>{trainDetails.train_no}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={3}>
                    <Text strong>Carriage No :</Text>
                </Col>
                <Col span={5}>
                    <Text>{trainDetails.carriage_no}</Text>
                </Col>
            </Row>



            <Title level={5} style={{ textAlign: "center", marginTop: '80px' }}>Get QR Code</Title>
            <Row justify="space-around" style={{ marginTop: "1em" }}>
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
                    <Button type="primary" onClick={() => GoToQRPage('Sinhala')}>Download QR</Button>
                </Col>
            </Row>
            <Row justify="space-around" style={{ marginTop: "1em" }}>
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
                    <Button type="primary" onClick={() => GoToQRPage('English')} >Download QR</Button>
                </Col>
            </Row>
            <Row justify="space-around" style={{ marginTop: "1em" }}>
                <Col sm={24} md={8}>
                    <Text strong>Tamil QR Code</Text>
                </Col>
                <Col sm={24} md={7}>
                    <Text type="secondary">http://traceapp.com/lIofRe</Text>
                </Col>
                <Col sm={24} md={1}>
                    <CopyTwoTone />
                </Col>
                <Col sm={24} md={6}>
                    <Button type="primary" onClick={() => GoToQRPage('Tamil')}>Download QR</Button>
                </Col>
            </Row>
        </div>
    )
}

export default TrainInfoDetails

