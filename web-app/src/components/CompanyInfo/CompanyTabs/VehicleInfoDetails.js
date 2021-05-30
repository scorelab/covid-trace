import React, { useEffect, useState } from 'react'
import { Col, Button, Typography, Divider, Row } from 'antd';
import { CopyTwoTone } from '@ant-design/icons';
import { Redirect, useParams, useHistory } from 'react-router-dom';
const { Text, Title } = Typography;

function VehicleInfoDetails(props) {


    const [vehicleDetails, setVehicleDetails] = useState({
        contact_number: "",
        key: "",
        location: "",
        location_id: "",
        location_type: "",
        name: "",
        org: "",
        vehicle_no: ""
    })

    let history = useHistory();

    function GoToQRPage(lang) {
        history.push({
            pathname: `/qrpage/${vehicleDetails.location}`,
            state: { ...vehicleDetails }
        })
    }

    useEffect(() => {
        console.log(props.companyDetails)
        props.data && setVehicleDetails({
            ...props.data
        })
    }, [props.companyDetails])

    return (
        <div>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Private Vehicle Details</Title>
            <Divider />

            <Row>
                <Col span={4}>
                    <Text strong>Name :</Text>
                </Col>
                <Col span={5}>
                    <Text>{vehicleDetails.name}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={4}>
                    <Text strong>Contact No :</Text>
                </Col>
                <Col span={5}>
                    <Text>{vehicleDetails.contact_number}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={4}>
                    <Text strong>Vehicle No :</Text>
                </Col>
                <Col span={5}>
                    <Text>{vehicleDetails.vehicle_no}</Text>
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
                    <Button type="primary" onClick={() => GoToQRPage('Sinhala')} data-toggle="tooltip" data-placement="top" title="Download QR Code">Download QR</Button>
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
                    <Button type="primary" onClick={() => GoToQRPage('English')} data-toggle="tooltip" data-placement="top" title="Download QR Code">Download QR</Button>
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
                    <Button type="primary" onClick={() => GoToQRPage('Tamil')} data-toggle="tooltip" data-placement="top" title="Download QR Code">Download QR</Button>
                </Col>
            </Row>
        </div>
    )
}

export default VehicleInfoDetails

