import React, { useEffect, useState } from "react";
import { Col, Button, Popover, Typography, Divider, Row } from "antd";
import { CopyTwoTone } from "@ant-design/icons";
import { useHistory } from "react-router-dom";
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
    train_no: "",
  });

  let history = useHistory();

  function GoToQRPage(lang) {
    history.push({
      pathname: `/qrpage/${trainDetails.location}`,
      state: { ...trainDetails },
    });
  }

  useEffect(() => {
    console.log(props.companyDetails);
    props.data &&
      setTrainDetails({
        ...props.data,
      });
  }, [props.companyDetails]);

  return (
    <div>
      <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>
        Train Details
      </Title>
      <Divider />

      <Row>
        <Col xs={8} md={4}>
          <Text strong>Train Name :</Text>
        </Col>
        <Col>
          <Text>{trainDetails.train_name}</Text>
        </Col>
      </Row>
      <Row style={{ marginTop: "0.5em" }}>
        <Col xs={8} md={4}>
          <Text strong>Train No :</Text>
        </Col>
        <Col>
          <Text>{trainDetails.train_no}</Text>
        </Col>
      </Row>
      <Row style={{ marginTop: "0.5em" }}>
        <Col xs={8} md={4}>
          <Text strong>Carriage No :</Text>
        </Col>
        <Col>
          <Text>{trainDetails.carriage_no}</Text>
        </Col>
      </Row>

      <Title level={5} style={{ textAlign: "center", marginTop: "80px" }}>
        Get QR Code
      </Title>
      <Row
        justify="space-around"
        style={{ textAlign: "center", marginTop: "1em" }}
      >
        <Col xs={24} sm={24} md={8}>
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
            onVisibleChange={props.getPopoverChangeFn(
              "sin",
              "http://traceapp.com/qWefeIG"
            )}
          >
            <CopyTwoTone />
          </Popover>
        </Col>
        <Col sm={24} md={6}>
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
        <Col xs={24} sm={24} md={8}>
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
            onVisibleChange={props.getPopoverChangeFn(
              "eng",
              "http://traceapp.com/eRjUklt"
            )}
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
      <Row
        justify="space-around"
        style={{ textAlign: "center", marginTop: "1em" }}
      >
        <Col xs={24} sm={24} md={8}>
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
            onVisibleChange={props.getPopoverChangeFn(
              "tam",
              "http://traceapp.com/lIofRe"
            )}
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
  );
}

export default TrainInfoDetails;
