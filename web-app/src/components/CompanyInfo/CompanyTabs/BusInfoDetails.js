import React, { useEffect, useState } from 'react'
import { Col, Button, Typography, Divider, Row, Popover } from 'antd';
import { CopyTwoTone } from '@ant-design/icons';
import { Redirect, useParams, useHistory } from 'react-router-dom';
const { Text, Title } = Typography;

function BusInfoDetails(props) {

    const [busDetails, setBusDetails] = useState({
        bus_no: "",
        bus_route_no: "",
        contact_number: "",
        key: "",
        location: "",
        location_id: "",
        location_type: "",
        name: "",
        org: "",
    })

    let history = useHistory();

    function GoToQRPage(lang) {
        history.push({
            pathname: `/qrpage/${busDetails.location}`,
            state: { ...busDetails }
        })
    }

    useEffect(() => {
        console.log(props.companyDetails)
        props.data && setBusDetails({
            ...props.data
        })
    }, [props.companyDetails])

    return (
        <div>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Bus Details</Title>
            <Divider />

            <Row>
                <Col span={4}>
                    <Text strong>Name :</Text>
                </Col>
                <Col span={5}>
                    <Text>{busDetails.name}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={4}>
                    <Text strong>Contact No :</Text>
                </Col>
                <Col span={5}>
                    <Text>{busDetails.contact_number}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={4}>
                    <Text strong>Bus No :</Text>
                </Col>
                <Col span={5}>
                    <Text>{busDetails.bus_no}</Text>
                </Col>
            </Row>
            <Row style={{ marginTop: "0.5em" }}>
                <Col span={4}>
                    <Text strong>Bus Route No :</Text>
                </Col>
                <Col span={5}>
                    <Text style={{marginLeft:'-15px'}}>{busDetails.bus_route_no}</Text>
                </Col>
            </Row>


            <Title level={5} style={{ textAlign: "center", marginTop: '80px' }}>Get QR Code</Title>
            <Row justify="space-around" style={{ marginTop: "1em" }}>
        <Col xs={0} sm={24} md={8}>
          <Text strong>Sinhala QR Code</Text>
        </Col>
        <Col sm={24} md={7}>
          <Text type="secondary">http://traceapp.com/qWefeIG</Text>
        </Col>
        <Col sm={24} md={1}>
          <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["sin"]}
            onVisibleChange={props.getPopoverChangeFn("sin", 'http://traceapp.com/qWefeIG')}
          >
            <CopyTwoTone />
          </Popover>
        </Col>
        <Col  sm={24} md={6}>
          <Button
            type="primary"
            onClick={() => GoToQRPage("Sinhala")}
            data-toggle="tooltip"
            data-placement="top"
            title="Download QR Code"
          >
            Download QR
          </Button>
        </Col>
      </Row>
      <Row justify="space-around" style={{ marginTop: "1em" }}>
        <Col xs={0} sm={24} md={8}>
          <Text strong>English QR Code</Text>
        </Col>
        <Col sm={24} md={7}>
          <Text type="secondary">http://traceapp.com/eRjUklt</Text>
        </Col>
        <Col sm={24} md={1}>
        <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["eng"]}
            onVisibleChange={props.getPopoverChangeFn("eng", 'http://traceapp.com/eRjUklt')}
          >
            <CopyTwoTone />
          </Popover>
        </Col>
        <Col sm={24} md={6}>
          <Button
            type="primary"
            onClick={() => GoToQRPage("English")}
            data-toggle="tooltip"
            data-placement="top"
            title="Download QR Code"
          >
            Download QR
          </Button>
        </Col>
      </Row>
      <Row justify="space-around" style={{ marginTop: "1em" }}>
        <Col xs={0} sm={24} md={8}>
          <Text strong>Tamil QR Code</Text>
        </Col>
        <Col sm={24} md={7}>
          <Text type="secondary">http://traceapp.com/lIofRe</Text>
        </Col>
        <Col sm={24} md={1}>
        <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["tam"]}
            onVisibleChange={props.getPopoverChangeFn("tam", "http://traceapp.com/lIofRe")}
          >
            <CopyTwoTone />
          </Popover>
        </Col>
        <Col sm={24} md={6}>
          <Button
            type="primary"
            onClick={() => GoToQRPage("Tamil")}
            data-toggle="tooltip"
            data-placement="top"
            title="Download QR Code"
          >
            Download QR
          </Button>
        </Col>
      </Row>
        </div>
    )
}



export default BusInfoDetails

