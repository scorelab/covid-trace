import React, { useState,useEffect } from 'react'
import { Card, Row, Col, Input, Checkbox, Button, message } from 'antd';
import { registerVehicle } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";

function VehicleReg(props) {

    let history = useHistory();

    useEffect(() => {
        if (props.Registration.registrationError == true) {
            warning();
        } else if (props.Registration.registrationError == false) {
            success();
            props.reset();
            history.push("/organisations");
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

    function submitDetails() {
        if (state.isCorrect == false) {
            warning();
        } else {
            console.log(state)
            props.registerVehicle({
                contact_number: state.contact_number,
                location_id: state.location_id,
                name: state.name,
                vehicle_no: state.vehicle_no,
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
        <div>
            <Card title="Fill these Details" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", height: "260px", position: "sticky" }}>
                <Row>
                    <Col span={24}>
                        <Input placeholder="Name" name="name" onChange={handleChange} />
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  >
                        <Input addonBefore="+94" placeholder="Contact No" name="contact_number" style={{ marginTop: '12px' }} onChange={handleChange} />
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={10} >
                        <Input placeholder="Vehical No" name="vehicle_no" style={{ marginTop: '12px' }} onChange={handleChange} />
                    </Col>
                </Row>
                <Row justify="space-between" align="middle">
                    <Col sm={24} md={10}  >
                        <Checkbox onChange={handleChange} name="isCorrect" style={{ marginTop: "35px" }} >Confirm Your Details Is Correct</Checkbox>
                    </Col>
                    <Col sm={24} md={10}   >
                        <Button type="primary" style={{ marginTop: "35px", width: "100%" }} onClick={submitDetails}>Submit</Button>
                    </Col>
                </Row>
            </Card>
        </div>
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

