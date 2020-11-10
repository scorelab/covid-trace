import React from 'react'
import { Layout, Card, Button,Table, Tag, Space} from 'antd';
import Navbar from '../UiElements/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
const { Content } = Layout;

const columns = [
    {
      title: 'Location',
      dataIndex: 'location',
      key: 'location',
      render: text => <a>{text}</a>,
    },
    {
      title: 'Approval Status',
      key: 'approvalStatus',
      dataIndex: 'approvalStatus',
      render: approvalStatuses => (
        <>
          {approvalStatuses.map(approvalStatus => {
              let color;
            if (approvalStatus === 'approved') {
              color = 'green';
            }else if(approvalStatus==='pending'){
                color='orange'
            }else{
                color='red'
            }

            return (
              <Tag color={color} key={approvalStatus}>
                {approvalStatus.toUpperCase()}
              </Tag>
            );
          })}
        </>
      ),
    },
    {
      title: '',
      key: 'action',
      render: (text, record) => (
        <Space size="middle">
          <Button size="small" type="primary">Details</Button>
        </Space>
      ),
    },
  ];
  

const data = [
    {
      key: '1',
      location: '194/78B,Flower Rd, Bambalapitiya',
      approvalStatus: ['approved'],
    },
    {
      key: '2',
      location: '200/90B,Flower Rd, Wellawatta',
      approvalStatus: ['pending'],
    },
    {
      key: '3',
      location: '110/14A,Flower Rd, Mount Lavinia',
      approvalStatus: [ 'Rejected'],
    },
  ];

function Locations(props) {
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Locations" style={{ width: '1000px', boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "50px", overflow: "auto", minHeight: "64vh",marginBottom:"150px", position: "sticky" }}>
                        <Table columns={columns} dataSource={data} />
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}

export default Locations

