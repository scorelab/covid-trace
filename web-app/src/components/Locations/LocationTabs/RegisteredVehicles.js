import React, { useState, useEffect } from 'react'
import { Layout, Divider, Button, Table, Tag, Space } from 'antd';
import { Typography } from 'antd';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
import { Redirect, useParams, useHistory } from 'react-router-dom';
const { Title } = Typography;

function RegisteredVehicles(props) {

    let { UserName } = useParams();

    let history = useHistory();

    const [state, setstate] = useState({
        orgList: []
    })

    function goToCompanyInfo(value) {
        history.push({
            pathname: `/companyInfo/${value.location}`,
            state: { ...value, location_type: 'sc_vehicle' }
        })
    }

    useEffect(() => {
        console.log("Vehicles")
        let tempReqOrgList = [];

        (props.locationReqestData && props.vehicleData) && (Object.keys(props.locationReqestData).map(locReqId => {
            if (props.locationReqestData[locReqId].org === UserName) {  
            (Object.keys(props.vehicleData).map(locationId => {
                if (props.locationReqestData[locReqId].location === locationId) {
                  tempReqOrgList.push({
                    ...props.locationReqestData[locReqId],
                    ...props.vehicleData[locationId],
                    key: locReqId,
                  })
                  //console.log(props.locationData[locationId])
                }
              }))
            }
        }))

        // console.log(tempOrgList)
        /*   setstate({
            orgList: tempOrgList
          }) */
        tempReqOrgList && setstate({
            orgList: tempReqOrgList
        })


    }, [props.vehicleData, props.locationReqestData])


    const columns = [
        {
            title: 'Vehicle No',
            dataIndex: 'vehicle_no',
            key: 'vehicle_no',
            render: (text) => <span title={text} className="hide-long-text">{text}</span>,
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
                    <Button size="small" onClick={() => goToCompanyInfo(record)} type="primary" data-toggle="tooltip" data-placement="top" title="View details of private vehicle">Details</Button>
                </Space>
            ),
        },
    ];



    return (
        <React.Fragment>
            <Title level={5} style={{ textAlign: "left", marginBottom: "-15px" }}>Registered Private Vehicles</Title>
            <Divider />

            <Table columns={columns} dataSource={state.orgList} />
        </React.Fragment>
    )
}

//export default RegisteredVehicles
const mapStateToProps = (state) => {
    //console.log(state)
    return ({
        ...state,
        user: state.auth.auth.user,
        locationReqestData: state.firestore.data.sc_request_status,
        vehicleData:state.firestore.data.sc_vehicle
    })
}



//export default RegisteredBuses

export default compose(
    firestoreConnect([
        { collection: 'sc_request_status' },
        { collection: 'sc_vehicle' },
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps),
)(RegisteredVehicles)
