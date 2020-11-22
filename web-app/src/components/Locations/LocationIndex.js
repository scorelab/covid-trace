import React from 'react'
import { Layout, Card, Tabs } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import BusinessLocations from './LocationTabs/BusinessLocations';
import RegisteredBuses from './LocationTabs/RegisteredBuses';
import RegisteredTrains from './LocationTabs/RegisteredTrains';
import RegisteredVehicles from './LocationTabs/RegisteredVehicles';
const { TabPane } = Tabs;
const { Content } = Layout;

function LocationIndex(props) {
    return (
        <Layout style={{ minHeight: "100vh" }}>
            <Navbar />
            <Content style={{ padding: '0 50px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <Card style={{ width: '950px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", height: "598px", position: "sticky" }}>
                    <Tabs tabPosition='left'>
                        <TabPane tab="Businesses" key="1">
                            <BusinessLocations />
                        </TabPane>
                        <TabPane tab="Vehicles" key="2">
                            <RegisteredVehicles />
                        </TabPane>
                        <TabPane tab="Buses" key="3">
                            <RegisteredBuses />
                        </TabPane>
                        <TabPane tab="Traines" key="4">
                            <RegisteredTrains />
                        </TabPane>
                    </Tabs>
                </Card>
            </Content>
            <BottomFooter />
        </Layout>
    )
}

export default LocationIndex

