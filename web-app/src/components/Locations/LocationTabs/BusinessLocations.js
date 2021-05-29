import React, { useState, useEffect } from 'react'
import { Layout, Divider, Button, Table, Tag, Space } from 'antd';
import { Typography } from 'antd';
import { connect } from 'react-redux'
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
import { Redirect, useParams, useHistory } from 'react-router-dom';
const { Title } = Typography;


function BusinessLocations(props) {

  let { UserName } = useParams();

  let history = useHistory();

  const [state, setstate] = useState({
    orgList: []
  })

  function goToCompanyInfo(value) {
    history.push({
      pathname: `/companyInfo/${value.location}`,
      state: { ...value, location_type: 'sc_location' }
    })
  }

  useEffect(() => {
    let tempReqOrgList = [];

    (props.locationData && props.locationReqestData) && (Object.keys(props.locationReqestData).map(locReqId => {
      if (props.locationReqestData[locReqId].org === UserName) {
        (Object.keys(props.locationData).map(locationId => {
          if (props.locationReqestData[locReqId].location === locationId) {
            tempReqOrgList.push({
              ...props.locationReqestData[locReqId],
              ...props.locationData[locationId],
              key: locReqId,
            })
            //console.log(props.locationData[locationId])
          }
        }))
        // console.log(props.locationReqestData[locReqId].org===UserName)

      }

    }))

    // console.log(tempOrgList)
    /*   setstate({
        orgList: tempOrgList
      }) */
    tempReqOrgList && setstate({
      orgList: tempReqOrgList
    })


  }, [props.locationData, props.locationReqestData])

  const columns = [
    {
      title: 'Address',
      dataIndex: 'address',
      key: 'address',
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

  /* 
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
        approvalStatus: ['Rejected'],
      },
    ];
   */

  if (props.user == null) return <Redirect to='/signIn' />

  return (
    <React.Fragment>
      <Title level={5} style={{ textAlign: "center", marginBottom: "-15px" }}>Registered Businesses</Title>
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
    locationData: state.firestore.data.sc_location,
    locationReqestData: state.firestore.data.sc_request_status
  })
}


//export default connect(mapStateToProps)(Locations)

export default compose(
  firestoreConnect([
    { collection: 'sc_location' },
    { collection: 'sc_request_status' }
  ]), // sync todos collection from Firestore into redux
  connect(mapStateToProps),
)(BusinessLocations)
