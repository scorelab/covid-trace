import React, { useState, useEffect } from 'react'
import cities from './Cities'
import { Card, Divider, Row, Col, Input, Select, Checkbox, Button, message, Typography } from 'antd';
import { registerBusiness } from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";
const { Option } = Select;


const { Title } = Typography;
function BusinessReg(props) {

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
        province: null,
        city: null,
        District: null,
        DistrictList: [],
        CityList: [],
        premise_type: null,
        postal_code: "",
        floor_no: "",
        unit_no: "",
        address: "",
        fb_url: "",
        google_plc: "",
        name: "",
        contact_no: "",
        isCorrect: false
    })

    function handleChangePremiseType(value) {
        setstate({
            ...state,
            premise_type: value
        })
    }

    function handleChangeCity(value) {
        setstate({
            ...state,
            city: value
        })
    }

    function handleChangeCity(value) {
        setstate({
            ...state,
            city: value
        })
    }

    function handleChangeInputs(e) {
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

    function handleChangeProvince(e) {
        let tempDistrictList = []
        Object.keys(cities[0][e]).map(i => {
            tempDistrictList.push(i)
        })

        setstate({
            ...state,
            DistrictList: tempDistrictList,
            province: e
        })
    }

    function handleChangeDistrict(e) {
        let tempCityList = []
        cities[0][state.province][e].map(i => {
            tempCityList.push(i)
        })

        setstate({
            ...state,
            CityList: tempCityList,
            District: e
        })
    }

    function submitDetails(e) {
        e.preventDefault();
        if (state.isCorrect == false) {
            warning();
        } else {
            props.registerBusiness({
                province: state.province,
                city: state.city,
                district: state.District,
                premise_type: state.premise_type,
                postal_code: state.postal_code,
                floor_no: state.floor_no,
                unit_no: state.unit_no,
                address: state.address,
                fb_url: state.fb_url,
                google_plc: state.google_plc,
                name: state.name,
                contact_no: state.contact_no,
                org: props.orgUserName
            })
        }
    }

    const warning = () => {
        message.warning('Please Check On the box');
    };

    const success = () => {
        message.success('You have successfully submit the details');
    };

    const error = () => {
        message.error('Registration Failed');
    };

    return (
            <Card title={<Title level={5}>Business Location Details</Title>}  style={{ width: '100%', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto", minHeight: "58vh", position: "sticky", marginBottom: '20px' }}>
                <form onSubmit={submitDetails}>
                    <Divider orientation="left">Basic Details</Divider>
                    <Row>
                        <Col span={24}> Name
                            <Input 
                            aria-label="Enter your Name"
                            placeholder="Name" name="name" value={state.name} onChange={handleChangeInputs} style={{ marginBottom: "5px", marginTop: "5px" }}  required/>
                        </Col>
                    </Row>
                    <Row justify="space-between" >
                        <Col sm={24} md={13}  > Contact Number
                            <Input 
                            aria-label="Enter your contact number"
                            addonBefore="+94" type="tel" maxLength="9" placeholder="Contact No" style={{ marginBottom: "5px", marginTop: "5px" }} name="contact_no" value={state.contact_no} onChange={handleChangeInputs} required />
                        </Col>
                        <Col sm={24} md={1}  >
                        </Col>
                        <Col sm={24} md={10} > Premise Type
                            <Select placeholder="Premise Type" style={{ width: "100%", marginBottom: "5px", marginTop: "5px" }} name="premise_type" value={state.premise_type} onChange={handleChangePremiseType} required>
                                <Option value="School">School</Option>
                                <Option value="Super Market">Super Market</Option>
                                <Option value="Grocery">Grocery</Option>
                                <Option value="Temple">Temple</Option>
                            </Select>
                        </Col>
                    </Row>
                    <Divider orientation="left">Location Details</Divider>
                    <Row justify="space-between" >
                        <Col sm={24} md={7}  > Province
                            <Select placeholder="Province" style={{ width: "100%", marginBottom: "5px", marginTop: "5px" }} onChange={handleChangeProvince}>
                                <Option value="Western">Western</Option>
                                <Option value="Eastern">Eastern</Option>
                                <Option value="Central">Central</Option>
                                <Option value="North Central">North Central</Option>
                                <Option value="Northern">Northern</Option>
                                <Option value="North Western">North Western</Option>
                                <Option value="Sabaragamuwa">Sabaragamuwa</Option>
                                <Option value="Southern">Southern</Option>
                                <Option value="Uva">Uva</Option>
                            </Select>
                        </Col>
                        <Col sm={24} md={1}  >
                        </Col>
                        <Col sm={24} md={7} > District
                            <Select placeholder="District" style={{ width: "100%",  marginBottom: "5px", marginTop: "5px" }} onChange={handleChangeDistrict}>
                                {

                                    state.DistrictList.map(i => {
                                        return <Option value={i} key={i}>{i}</Option>
                                    })

                                }
                            </Select>
                        </Col>
                        <Col sm={24} md={1}></Col>
                        <Col sm={24} md={7} >City
                            <Select placeholder="City" style={{ width: "100%", marginBottom: "5px", marginTop: "5px" }} name="city" onChange={handleChangeCity}>

                                {
                                    state.CityList.map(i => {
                                        return <Option value={i} key={i}>{i}</Option>
                                    })
                                }
                            </Select>
                        </Col>
                    </Row>
                    <Row justify="space-between" >
                        <Col sm={24} md={7}  > Postal Code
                            <Input 
                            aria-label="Enter the postal code"
                            placeholder="Postal Code" name="postal_code"  onChange={handleChangeInputs} style={{ marginBottom: "5px", marginTop: "5px" }}/>
                        </Col>
                        <Col sm={24} md={1}  >
                        </Col>
                        <Col sm={24} md={7} > Floor Number
                            <Input 
                            aria-label="Enter the floor number"
                            placeholder="Floor No" name="floor_no" type="number" min="0" onChange={handleChangeInputs} style={{ marginBottom: "5px", marginTop: "5px" }} />
                        </Col>
                        <Col sm={24} md={1}></Col>
                        <Col sm={24} md={7} > Unit Number
                            <Input 
                            aria-label="Enter the unit number"
                            placeholder="Unit No" onChange={handleChangeInputs} type="number" min="0" name="unit_no" style={{ marginBottom: "5px", marginTop: "5px" }} />
                        </Col>
                    </Row>
                    <Row>
                        <Col span={24}> Address
                            <Input 
                            aria-label="Enter the address"
                            placeholder="Address" name="address" onChange={handleChangeInputs} style={{ marginBottom: "5px", marginTop: "5px" }} required/>
                        </Col>
                    </Row>
                    <Divider orientation="left">Internet Details</Divider>
                    <Row>
                        <Col span={24}> Facebook page URL
                            <Input 
                            aria-label="Enter the facebook page URL"
                            placeholder="FB Page URL" name="fb_url" type="url" onChange={handleChangeInputs} style={{ marginBottom: "5px", marginTop: "5px" }} />
                        </Col>
                    </Row>
                    <Row>
                        <Col span={24}> Google Place
                            <Input 
                            aria-label="Enter the google place"
                            placeholder="Google Place" name="google_plc" onChange={handleChangeInputs} style={{ marginTop: "5px" }} />
                        </Col>
                    </Row>
                    <Row justify="space-between" align="middle">
                        <Col sm={24} md={25}  >
                            <Checkbox 
                            aria-label="Click here to declare that the above information is true and correct to the best of your knowledge"
                            onChange={handleChangeInputs} name="isCorrect" style={{ marginTop: "10px" }} >I hereby declare that the above information is true and correct to the best of my knowledge.</Checkbox>
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
        registerBusiness: (business) => dispatch(registerBusiness(business)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(BusinessReg)

