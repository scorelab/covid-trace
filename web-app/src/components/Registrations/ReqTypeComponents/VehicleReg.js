import React, { useState, useEffect } from 'react'
import { Card, Divider, Row, Col, Input, Checkbox, Button, message, Typography } from 'antd';
import { registerVehicle } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";

const { Title } = Typography;

function VehicleReg(props) {

    let history = useHistory();

    useEffect(() => {
        if (props.Registration.registrationError == true) {
            warning();
        } else if (props.Registration.registrationError == false) {
            success();
            props.reset();
            history.push("/organizations");
        }
    }, [props.Registration.registrationError])

    const [state, setstate] = useState({
        contact_number: '',
        location_id: 'locid' + Math.floor(Math.random() * 10000),
        name: '',
        vehicle_no: '',
        isCorrect: false
    })

    function handleChange(e) {
        const value = e.target.value;
        const name = e.target.name;
        if (name == 'isCorrect') {
            setstate({
                ...state,
                isCorrect: e.target.checked
            })
        } else {
            setstate({
                ...state,
                [name]: value
            })
        }
    }

    function submitDetails(e) {
        e.preventDefault();
        if (state.isCorrect == false) {
            warning();
        } else {
            console.log(state)
            props.registerVehicle({
                contact_number: state.contact_number,
                location_id: state.location_id,
                name: state.name,
                vehicle_no: state.vehicle_no,
                org: props.orgUserName
            })
            /* f.firestore().collection('/sc_vehicle').add({
                contact_number:state.contact_number,
                location_id:state.location_id,
                name:state.name,
                vehicle_no:state.vehicle_no,
            })
                .then((e) => {
                    console.log("Document Created: ", e)
                    success();
                })
                .catch((e) => {
                    console.log("Error: ", e)
                    error()
                }) */
        }
    }

    const warning = () => {
        message.warning('Please Check On the box');
    };

    const success = () => {
        message.success('You have successfully submit the details');
    };

    const error = () => {
        message.error('Oops, Registration Failed');
    };

    return (
            <Card title={<Title level={5}>Private Vehicle Details</Title>}  style={{ width: '100%', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", marginBottom: "10px", overflow: "auto", minHeight: "260px", position: "sticky" }}>
                <form onSubmit={submitDetails}>
                    <Divider orientation="left">Vehicle Details</Divider>
                    <Row>
                        <Col span={24}> Vehicle Number
                            <Input 
                            aria-label="Enter the vehicle number"
                            placeholder="Vehical No" name="vehicle_no" style={{marginBottom: "10px", marginTop: "10px"  }} onChange={handleChange} required/>
                        </Col>
                    </Row>
                    <Divider orientation="left">Owner Details</Divider>
                    <Row justify="space-between">
                        <Col sm={24} md={13}> Name
                            <Input 
                            aria-label="Enter your Name"
                            placeholder="Name" name="name" style={{marginBottom: "10px", marginTop: "10px"}}  onChange={handleChange} required/>
                        </Col>
                        <Col sm={24} md={10}  > Contact Number
                            <Input 
                            aria-label="Enter your contact number"
                            addonBefore="+94" placeholder="Contact No" type="tel" maxLength="9" name="contact_number" style={{marginBottom: "10px", marginTop: "10px"  }} onChange={handleChange} required/>
                        </Col>
                    </Row>
                    <Row justify="space-between" align="middle">
                        <Col sm={24} md={25}  >
                            <Checkbox 
                            aria-label="Click here to declare that the above information is true and correct to the best of your knowledge"
                            onChange={handleChange} name="isCorrect" style={{ marginTop: "10px" }} >I hereby declare that the above information is true and correct to the best of my knowledge.</Checkbox>
                        </Col>
                    </Row>
                    <Row style={{ display: 'flex', justifyContent: 'center', marginTop: '10px' }}>
                        <Button
                            type="primary"
                            style={{ marginRight: '20px',width:'140px' }}
                            htmlType="submit"
                            data-toggle="tooltip" data-placement="top" title="Add organization entity"
                            >
                            Add Entity
                        </Button>
                    </Row>
                </form>
            </Card>
    )
}

const mapStateToProps = (state) => {
    console.log(state)
    return state
}

const mapDispatchToProps = (dispatch) => {
    return {
        registerVehicle: (vehicle) => dispatch(registerVehicle(vehicle)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(VehicleReg)

