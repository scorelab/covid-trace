import React, { useState,useEffect } from 'react'
import cities from './Cities'
import { Card, Divider, Row, Col, Input, Select, Checkbox, Button, message } from 'antd';
import {registerBusiness} from '../../../store/actions/registrationActions';
import { connect } from 'react-redux'
const { Option } = Select;

function BusinessReg(props) {

    useEffect(() => {
        if (props.Registration.registrationError == true) {
            warning();
        } else if (props.Registration.registrationError == false) {
            success();
        }
    }, [props.Registration.registrationError])

    const [state, setstate] = useState({
        province: null,
        city: null,
        District: null,
        DistrictList: [],
        CityList: [],
        premise_type: "",
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

    function submitDetails() {
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
        message.error('Oops, Registration Failed');
      };

    return (
        <div>
            <Card title="Fill these Details" style={{ width: '674px', boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.25)', marginTop: "20px", overflow: "auto",minHeight: "58vh", position: "sticky",marginBottom:'20px'}}>
                <Row>
                    <Col span={24}>
                        <Input placeholder="Name" name="name" value={state.name} onChange={handleChangeInputs} />
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={13}  >
                        <Input addonBefore="+94" placeholder="Contact No" style={{ marginTop: '12px' }} name="contact_no" value={state.contact_no} onChange={handleChangeInputs} />
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={10} >
                        <Select placeholder="Premise Type" style={{ width: "100%", marginTop: '12px' }} name="premise_type" value={state.premise_type} onChange={handleChangePremiseType}>
                            <Option value="School">School</Option>
                            <Option value="Super Market">Super Market</Option>
                            <Option value="Grocery">Grocery</Option>
                            <Option value="Temple">Temple</Option>
                        </Select>
                    </Col>
                </Row>
                <Divider orientation="left">Location</Divider>
                <Row justify="space-between" >
                    <Col sm={24} md={7}  >
                        <Select placeholder="Province" style={{ width: "100%", marginTop: '12px' }} onChange={handleChangeProvince}>
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
                    <Col sm={24} md={7} >
                        <Select placeholder="District" style={{ width: "100%", marginTop: '12px' }} onChange={handleChangeDistrict}>
                            {

                                state.DistrictList.map(i => {
                                    return <Option value={i} key={i}>{i}</Option>
                                })

                            }
                        </Select>
                    </Col>
                    <Col sm={24} md={1}></Col>
                    <Col sm={24} md={7} >
                        <Select placeholder="City" style={{ width: "100%", marginTop: '12px' }} name="city" onChange={handleChangeCity}>

                            {
                                state.CityList.map(i => {
                                    return <Option value={i} key={i}>{i}</Option>
                                })
                            }
                        </Select>
                    </Col>
                </Row>
                <Row justify="space-between" >
                    <Col sm={24} md={7}  >
                        <Input placeholder="Postal Code" name="postal_code" onChange={handleChangeInputs} style={{ marginTop: "12px" }} />
                    </Col>
                    <Col sm={24} md={1}  >
                    </Col>
                    <Col sm={24} md={7} >
                        <Input placeholder="Floor No" name="floor_no" onChange={handleChangeInputs} style={{ marginTop: "12px" }} />
                    </Col>
                    <Col sm={24} md={1}></Col>
                    <Col sm={24} md={7} >
                        <Input placeholder="Unit No" onChange={handleChangeInputs} name="unit_no" style={{ marginTop: "12px" }} />
                    </Col>
                </Row>
                <Row>
                    <Col span={24}>
                        <Input placeholder="Address" name="address" onChange={handleChangeInputs} style={{ marginTop: "12px" }} />
                    </Col>
                </Row>
                <Divider orientation="left"></Divider>
                <Row>
                    <Col span={24}>
                        <Input placeholder="FB Page URL" name="fb_url" onChange={handleChangeInputs} />
                    </Col>
                </Row>
                <Row>
                    <Col span={24}>
                        <Input placeholder="Google Place" name="google_plc" onChange={handleChangeInputs} style={{ marginTop: "10px" }} />
                    </Col>
                </Row>
                <Row justify="space-between" align="middle">
                    <Col sm={24} md={10}  >
                        <Checkbox onChange={handleChangeInputs} name="isCorrect" style={{ marginTop: "40px" }} >Confirm Your Details Is Correct</Checkbox>
                    </Col>
                    <Col sm={24} md={10}   >
                        <Button type="primary" style={{ marginTop: "40px", width: "100%" }} onClick={submitDetails} >Submit</Button>
                    </Col>
                </Row>

            </Card>
        </div>
    )
}

const mapStateToProps = (state)=>{
    console.log(state)
    return state
}

const mapDispatchToProps = (dispatch)=>{
    return {
        registerBusiness:(business)=>dispatch(registerBusiness(business))
    }
}

export default connect(mapStateToProps,mapDispatchToProps)(BusinessReg)

