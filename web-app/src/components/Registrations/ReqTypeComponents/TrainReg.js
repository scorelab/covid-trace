import React, { useEffect, useState } from 'react'
import { Card, Row, Col, Input, Checkbox, Button,message, Typography } from 'antd';
import { registerTrain } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";

const { Title } = Typography;

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
 
            <Card title={<Title level={5}>Train Details</Title>}  style={{ width: '100%', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", marginBottom: "10px", overflow: "auto", minHeight: "260px", position: "sticky" }}>
            <form onSubmit={submitDetails}>
                <Row>
                    <Col span={24}> Train Name
                        <Input 
                        aria-label="Enter the train number"
                        placeholder="Train Name" name="train_name" style= {{marginBottom: "10px", marginTop: "10px" }} onChange={handleChange} required/>
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  > Train Number
                        <Input 
                        aria-label="Enter train number"
                        placeholder="Train No" name="train_no" style={{  marginBottom: "10px", marginTop: "10px"  }} onChange={handleChange} required/>
                    </Col>
                    <Col sm={24} md={10} > Carriage Number
                        <Input 
                        aria-label="Enter carriage number"
                        placeholder="Carriage No" name="carriage_no" style={{ marginBottom: "10px", marginTop: "10px"  }} onChange={handleChange} required/>
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
        registerTrain: (train) => dispatch(registerTrain(train)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(TrainReg)

