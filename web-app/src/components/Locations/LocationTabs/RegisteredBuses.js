import React, { useState, useEffect } from 'react'
import { Layout, Divider, Button, Table, Tag, Space } from 'antd';
import { Typography } from 'antd';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
import { Redirect, useParams, useHistory } from 'react-router-dom';
const { Title } = Typography;


function RegisteredBuses(props) {


    let history = useHistory();

    let { UserName } = useParams();

    const [state, setstate] = useState({
        orgList: []
    })

    function goToCompanyInfo(value) {
        history.push({
            pathname: `/companyInfo/${value.location}`,
            state: { ...value, location_type: 'sc_bus' }
        })
    }

    useEffect(() => {
        console.log("Buses")
        let tempReqBusList = [];

        (props.locationReqestData && props.busData) && (Object.keys(props.locationReqestData).map(locReqId => {
            if (props.locationReqestData[locReqId].org === UserName) { 
            (Object.keys(props.busData).map(locationId => {
                if (props.locationReqestData[locReqId].location === locationId) {
                    tempReqBusList.push({
                    ...props.locationReqestData[locReqId],
                    ...props.busData[locationId],
                    key: locReqId,
                  })
                  //console.log(props.locationData[locationId])
                }
              }))
            }
        }))

      setstate({
            orgList: tempReqBusList
        })


    }, [props.busData, props.locationReqestData])


    const columns = [
        {
            title: 'Bus No',
            dataIndex: 'bus_no',
            key: 'bus_no',
            render: text => <a>{text}</a>,
        },
        {
            title: 'Approval Status',
            key: 'Status',
            dataIndex: 'Status',
            render: approvalStatus => {
                let color;
                if (approvalStatus === 'approved') {
                    color = 'green';
                } else if (approvalStatus === 'pending') {
                    color = 'orange'
                } else {
                    color = 'red'
                }
                return (
                    <Tag color={color} key={approvalStatus}>
                        {approvalStatus.toUpperCase()}
                    </Tag>
                );
            }
        },
        {
            title: '',
            key: 'action',
            render: (text, record) => (
                <Space size="middle">
                    <Button size="small" onClick={() => goToCompanyInfo(record)} type="primary">Details</Button>
                </Space>
            ),
        },
    ];



    return (
        <React.Fragment>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Registered Buses</Title>
            <Divider />

            <Table columns={columns} dataSource={state.orgList} />
        </React.Fragment>

    )
}


const mapStateToProps = (state) => {
    //console.log(state)
    return ({
        ...state,
        user: state.auth.auth.user,
        locationReqestData: state.firestore.data.sc_request_status,
        busData:state.firestore.data.sc_bus
    })
}



//export default RegisteredBuses

export default compose(
    firestoreConnect([
        { collection: 'sc_request_status' },
        { collection: 'sc_bus' },
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(RegisteredBuses)

