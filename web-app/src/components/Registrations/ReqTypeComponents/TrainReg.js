import React, { useEffect, useState } from 'react'
import { Card, Row, Col, Input, Checkbox, Button,message } from 'antd';
import { registerTrain } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";

function TrainReg(props) {

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
        carriage_no: '',
        location_id: '',
        train_name: '',
        train_no: '',
        isCorrect: false,
        location_id: 'locid' + Math.floor(Math.random() * 10000),
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
            props.registerTrain({
                carriage_no: state.carriage_no,
                location_id: state.location_id,
                train_name: state.train_name,
                train_no: state.train_no,
                location_id: state.location_id,
                org:props.orgUserName
            })
            /* f.firestore().collection('/sc_train').add({
                carriage_no: state.carriage_no,
                location_id: state.location_id,
                train_name: state.train_name,
                train_no: state.train_no,
                location_id: state.location_id,
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
            <form onSubmit={submitDetails}>
                <Row>
                    <Col span={24}>
                        <Input placeholder="Train Name" name="train_name" onChange={handleChange} required/>
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  >
                        <Input placeholder="Train No" name="train_no" style={{ marginTop: '12px' }} onChange={handleChange} required/>
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={10} >
                        <Input placeholder="Carriage No" name="carriage_no" style={{ marginTop: '12px' }} onChange={handleChange} required/>
                    </Col>
                </Row>
                <Row justify="space-between" align="middle">
                    <Col sm={24} md={10}  >
                        <Checkbox onChange={handleChange} style={{ marginTop: "35px" }} name="isCorrect" >Confirm Your Details Is Correct</Checkbox>
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
    console.log(state)
    return state
}

const mapDispatchToProps = (dispatch) => {
    return {
        registerTrain: (train) => dispatch(registerTrain(train)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(TrainReg)

