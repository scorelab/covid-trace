import React, { useEffect, useState } from 'react'
import { Card, Row, Col, Input, Checkbox, Button, message } from 'antd';
import { registerBus } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";

function BusReg(props) {

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
        bus_no: '',
        bus_route_no: '',
        contact_number: '',
        location_id: 'locid' + Math.floor(Math.random() * 10000),
        name: '',
        isCorrect: false
    })

    function onChange(e) {
        console.log(`checked = ${e.target.checked}`);
    }

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
            props.registerBus({
                bus_no: state.bus_no,
                bus_route_no: state.bus_route_no,
                contact_number: state.contact_number,
                location_id: state.location_id,
                name: state.name,
                org:props.orgUserName
            })
            /* f.firestore().collection('/sc_bus').add({
                bus_no: state.bus_no,
                bus_route_no: state.bus_route_no,
                contact_number: state.contact_number,
                location_id: state.location_id,
                name: state.name,
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
            <Card title="Fill these Details" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", minHeight: "260px", position: "sticky" }}>
                <form onSubmit={submitDetails}>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  >
                        <Input placeholder="Bus No" name="bus_no" onChange={handleChange} required/>
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={10} >
                        <Input placeholder="Bus Route No" name="bus_route_no" onChange={handleChange} required/>
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  >
                        <Input placeholder="Name" name="name" style={{ marginTop: '12px' }} onChange={handleChange} required/>
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={10} >
                        <Input addonBefore="+94" placeholder="Contact No" name="contact_number" onChange={handleChange} style={{ marginTop: '12px' }} required/>
                    </Col>
                </Row>
                <Row justify="space-between" align="middle">
                    <Col sm={24} md={10}  >
                        <Checkbox onChange={handleChange} name="isCorrect" style={{ marginTop: "35px" }} >Confirm Your Details Is Correct</Checkbox>
                    </Col>
                    <Col sm={24} md={10}   >
                        <Button type="primary" style={{ marginTop: "35px", width: "100%" }} htmlType="submit">Submit</Button>
                    </Col>
                </Row>
                </form>
            </Card>
        </div>
    )
}

const mapStateToProps = (state) => {
    //console.log(state)
    return state
}

const mapDispatchToProps = (dispatch) => {
    return {
        registerBus: (bus) => dispatch(registerBus(bus)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(BusReg)

