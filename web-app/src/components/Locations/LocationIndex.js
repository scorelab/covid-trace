import React, { useEffect, useState } from "react";
import { Redirect, useParams } from "react-router-dom";
import { Layout, Card, Tabs, Typography, Row, Col } from "antd";
import { compose } from "redux";
import { firestoreConnect } from "react-redux-firebase";
import { connect } from "react-redux";
import Navbar from "../UiElements/Navbar/Navbar";
import BottomFooter from "../UiElements/BottomFooter";
import BusinessLocations from "./LocationTabs/BusinessLocations";
import RegisteredBuses from "./LocationTabs/RegisteredBuses";
import RegisteredTrains from "./LocationTabs/RegisteredTrains";
import RegisteredVehicles from "./LocationTabs/RegisteredVehicles";
const { TabPane } = Tabs;
const { Content } = Layout;
const { Title } = Typography;

function LocationIndex(props) {
  let { UserName } = useParams();

  const [orgName, setOrgName] = useState({
    name: "",
    username: "",
    phonenumber: false,
  });

  useEffect(() => {
    props.orgData &&
      props.orgWithUserData &&
      Object.keys(props.orgData).map((orgId) => {
        if (props.orgData[orgId].UserName === UserName) {
          Object.keys(props.orgWithUserData).map((orgId2) => {
            if (props.orgWithUserData[orgId2].org === UserName) {
              if (
                props.orgWithUserData[orgId2].phoneNumber ===
                props.user.phoneNumber
              ) {
                setOrgName({
                  name: props.orgData[orgId].Name,
                  username: UserName,
                  phonenumber: true,
                });
              }
            }
          });
        }
      });
  }, [props.orgData, props.orgWithUserData]);

  //console.log(phonenumber)
  // console.log(props.user.phoneNumber)

  // if (orgName.phonenumber) return <Redirect to='/signIn' />

  return (
    <Layout style={{ minHeight: "100vh" }}>
     <Navbar dimensions={props.dimensions} />
      {orgName.name && orgName.username && orgName.phonenumber ? (
        <Content
          style={{
            padding: "0 50px",
            display: "flex",
            alignItems: "center",
            flexFlow: "column wrap",
          }}
        >
          <Title
            level={5}
            style={{
              textAlign: "center",
              marginBottom: "-10px",
              marginTop: "15px",
            }}
          >
            Locations and Vehicles for {orgName.name} ({orgName.username})
          </Title>
          <Card
            style={{
              width: "95%",
              minWidth: "auto",
              boxShadow: "0px 2px 2px rgba(0, 0, 0, 0.25)",
              marginTop: "20px",
              height: "598px",
              position: "sticky",
            }}
          >
            <Row>
              <Col span="24">
                <Tabs tabPosition={ props.dimensions.width > 636 ? 'left' : 'top'}>
                  <TabPane
                    tab="Locations"
                    key="1"
                    data-toggle="tooltip"
                    data-placement="top"
                    title="View business locations"
                  >
                    <BusinessLocations />
                  </TabPane>
                  <TabPane
                    tab="Private Vehicles"
                    key="2"
                    data-toggle="tooltip"
                    data-placement="top"
                    title="View private vehicles"
                  >
                    <RegisteredVehicles />
                  </TabPane>
                  <TabPane
                    tab="Buses"
                    key="3"
                    data-toggle="tooltip"
                    data-placement="top"
                    title="View buses"
                  >
                    <RegisteredBuses />
                  </TabPane>
                  <TabPane
                    tab="Trains"
                    key="4"
                    data-toggle="tooltip"
                    data-placement="top"
                    title="View trains"
                  >
                    <RegisteredTrains />
                  </TabPane>
                </Tabs>
              </Col>
            </Row>
          </Card>
        </Content>
      ) : (
        <div
          style={{
            display: "flex",
            justifyContent: "center",
          }}
        >
          <p style={{ marginBottom: "41%" }}>
            Either Page not found or you are restricted to access this
            organization's details
          </p>
        </div>
      )}
      <BottomFooter />
    </Layout>
  );
}

const mapStateToProps = (state) => {
  return {
    ...state,
    user: state.auth.auth.user,
    orgData: state.firestore.data.sc_org,
    orgWithUserData: state.firestore.data.sc_org_users,
  };
};

export default compose(
  firestoreConnect([{ collection: "sc_org" }, { collection: "sc_org_users" }]), // sync todos collection from Firestore into redux
  connect(mapStateToProps)
)(LocationIndex);

// export default LocationIndex
