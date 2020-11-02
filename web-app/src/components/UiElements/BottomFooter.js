import React from 'react'
import { Layout, Typography } from 'antd';
const {  Footer } = Layout;
const {  Text } = Typography;

function BottomFooter() {
    return (
        <div>
            <Footer style={{ background: 'rgba(0, 0, 0, 0.60)', height: '25px', padding: '1px', display: 'flex', justifyContent: 'space-around' }}>
                <Text style={{ color: "white" }}>&copy;2020</Text>
                <Text style={{ color: "white" }}>Terms Of Use</Text>
            </Footer>
        </div>
    )
}

export default BottomFooter

