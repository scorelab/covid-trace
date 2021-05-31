import React, { useEffect, useState } from "react";
import { Col, Button, Typography, Divider, Row, Popover, Tooltip } from "antd";
import { CopyTwoTone } from "@ant-design/icons";
import { Redirect, useParams, useHistory } from "react-router-dom";
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
  });

  let history = useHistory();

  function GoToQRPage(lang) {
    history.push({
      pathname: `/qrpage/${busDetails.location}`,
      state: { ...busDetails },
    });
  }

  useEffect(() => {
    console.log(props.companyDetails);
    props.data &&
      setBusDetails({
        ...props.data,
      });
  }, [props.companyDetails]);

  return (
    <div>
      <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>
        Bus Details
      </Title>
      <Divider />
      <Row>
        <Col xs={8} md={4}>
          <Text strong>Name :</Text>
        </Col>
        <Col>
          <Text>{busDetails.name}</Text>
        </Col>
      </Row>
      <Row style={{ marginTop: "0.5em" }}>
        <Col xs={8} md={4}>
          <Text strong>Contact No :</Text>
        </Col>
        <Col>
          <Text>{busDetails.contact_number}</Text>
        </Col>
      </Row>
      <Row style={{ marginTop: "0.5em" }}>
        <Col xs={8} md={4}>
          <Text strong>Bus No :</Text>
        </Col>
        <Col>
          <Text>{busDetails.bus_no}</Text>
        </Col>
      </Row>
      <Row style={{ marginTop: "0.5em" }}>
        <Col xs={8} md={4}>
          <Text strong>Bus Route No :</Text>
        </Col>
        <Col>
          <Text>{busDetails.bus_route_no}</Text>
        </Col>
      </Row>


      <Title level={5} style={{ textAlign: "left", marginTop: "80px" }}>
        Get QR Code
      </Title>
      <Divider />
      <Row
        justify="space-around"
        style={{ textAlign: "center", marginTop: "1em" }}
      >
        <Col xs={24} sm={24} lg={8}>
          <Text strong>Sinhala QR Code</Text>
        </Col>
        <Col sm={24} lg={7}>
          <Text type="secondary">http://traceapp.com/qWefeIG</Text>
        </Col>
        <Col sm={24} lg={1}>
        <Tooltip title="Copy Sinhala QR Code Link">
          <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["sin"]}
            onVisibleChange={props.getPopoverChangeFn(
              "sin",
              "http://traceapp.com/qWefeIG"
            )}
          >
            <CopyTwoTone />
          </Popover>
          </Tooltip>
        </Col>
        <Col sm={24} lg={6}>
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
      <Row
        justify="space-around"
        style={{ textAlign: "center", marginTop: "1em" }}
      >
        <Col xs={24} sm={24} lg={8}>
          <Text strong>English QR Code</Text>
        </Col>
        <Col sm={24} lg={7}>
          <Text type="secondary">http://traceapp.com/eRjUklt</Text>
        </Col>
        <Col sm={24} lg={1}>
        <Tooltip title="Copy English QR Code Link">
          <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["eng"]}
            onVisibleChange={props.getPopoverChangeFn(
              "eng",
              "http://traceapp.com/eRjUklt"
            )}
          >
            <CopyTwoTone />
          </Popover>
          </Tooltip>
        </Col>
        <Col sm={24} lg={6}>
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
      <Row
        justify="space-around"
        style={{ textAlign: "center", marginTop: "1em" }}
      >
        <Col xs={24} sm={24} lg={8}>
          <Text strong>Tamil QR Code</Text>
        </Col>
        <Col sm={24} lg={7}>
          <Text type="secondary">http://traceapp.com/lIofRe</Text>
        </Col>
        <Col sm={24} lg={1}>
        <Tooltip title="Copy Tamil QR Code Link">
          <Popover
            content="Text Copied"
            trigger="click"
            visible={props.copyPopoverState["tam"]}
            onVisibleChange={props.getPopoverChangeFn(
              "tam",
              "http://traceapp.com/lIofRe"
            )}
          >
            <CopyTwoTone />
          </Popover>
          </Tooltip>
        </Col>
        <Col sm={24} lg={6}>
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
  );
}

export default BusInfoDetails;
