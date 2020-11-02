import React from 'react'
import enter from '../../assets/enter.png'
import family from '../../assets/family.png'
import { Layout, Typography, Avatar } from 'antd';
const { Header } = Layout;
const { Title, Text } = Typography;

function Navbar(props) {
    return (
        <div>
            <Header style={{ background: '#F9F9F9', boxShadow: '0px 1px 4px rgba(0, 0, 0, 0.25)', height: '60px', paddingTop: "5px", paddingLeft: "20px" }}>
                <Avatar size="large" src={enter} style={{ float: 'left' }} />
                <Title level={3} style={{ marginTop: "10px" }}> SAFE CHECK IN</Title>
            </Header>
            <Header style={{ background: 'rgba(29, 233, 182, 0.23)', height: '50px', display: 'flex', alignItems: "center", paddingLeft: "20px" }}>
                <Avatar size={35} src={family} style={{ float: 'left', }} />
                <Text style={{ color: "#626262", marginLeft: "5px", marginTop: "5px" }}>Safe Check-in & Checkout Voluntary Drive to Expose Potential Covid-19 Spread  |  Stay Home & Stay Safe</Text>
            </Header>
        </div>
    )
}

export default Navbar

