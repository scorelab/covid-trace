import React, { useEffect, useState } from 'react'
import { Layout, Card, Row, Col, Input, Button, message, Typography } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';
import { registerOrganisations } from '../../store/actions/registrationActions';
import { useHistory } from "react-router-dom";
import { firestoreConnect } from 'react-redux-firebase'
import { compose } from 'redux'
const { Content } = Layout;
const { Title } = Typography;

function AddOrganisation(props) {

    let history = useHistory();

    useEffect(() => {
         if (props.orgRegError) {
            error();
        } else if(props.orgRegError===false) {
                success();
                props.reset();
                history.push("/organizations");
        } 

    },[props.orgRegError,props.orgData])


    const [state, setstate] = useState({
        Name: '',
        UserName: '',
        WebSite: '',
    })

    function handleChange(e) {
        const value = e.target.value;
        const name = e.target.name;

        setstate({
            ...state,
            [name]: value
        })

    }

    function handleSubmit() {

        //console.log(state.UserName)
        if(state.UserName!='' && state.Name!=''){
            let isUserNameExist = false
            console.log(1)
            if(props.orgData) {
                (Object.keys(props.orgData).map(i=>{
                    if(props.orgData[i].UserName===state.UserName){
                        errorUserExists();
                        isUserNameExist=true;
                    }
                }))
            } 
            console.log(2)
            //console.log(props.orgData)
            if(isUserNameExist===false){
                props.registerOrganisations({
                    ...state,
                    phoneNumber:props.user.phoneNumber
                })
            }
        }else{
            warning();
        }
       
        
    }

    const error = () => {
        message.error('Error');
    };

    const errorUserExists = () => {
        message.error('Your org user name is already exist on the system,Please enter new username');
    };

    const success = () => {
        message.success('Registration Completed');
    };

    const warning = () => {
        message.warning('Please fill out the form to add your organization');
      };


    if (props.user == null) return <Redirect to='signIn' />
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
               <Navbar dimensions={props.dimensions} />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title={<Title level={5}>Add New Organization</Title>} style={{ width: '620px', boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "25px", height: '290px' }}>
                        <div style={{ margin: "5px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>
                            <Row>
                                <Col span={12}>
                                    Name of the Organization
                                </Col>
                                <Col span={12}>
                                    <Input defaultValue="" placeholder="Name of the Organization" aria-label="Enter the name of your organization" aria-required="true" name="Name" style={{ marginBottom: '10px' }} onChange={handleChange} />
                                </Col>
                            </Row>
                            <Row>
                                <Col span={12}>
                                    Username of the Organization
                                </Col>
                                <Col span={12}>
                                    <Input defaultValue="" placeholder="Username of the Organization" aria-label="Enter the username of your organization" aria-required="true" name="UserName" style={{ marginBottom: '10px' }} onChange={handleChange} />
                                </Col>
                            </Row>
                            <Row>
                                <Col span={12}>
                                    Website URL
                                </Col>
                                <Col span={12}>
                                    <Input defaultValue="" placeholder="Website URL" aria-label="Enter the URL to your organization website" aria-required="true" name="WebSite" style={{ marginBottom: '10px' }} onChange={handleChange} />
                                </Col>
                            </Row>
                            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: "center", paddingTop: '10px' }}>
                                <Button type="primary" style={{ width: "150px" }} onClick={handleSubmit} data-toggle="tooltip" data-placement="top" title="Add organization">Add Organization</Button>
                            </div>

                        </div>
                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div>
    )
}

const mapStateToProps = (state,ownProps) => {
        return ({
            ...state,
            user: state.auth.auth.user,
            orgRegError: state.Registration.orgRegError,
            orgWithUserRegError: state.Registration.orgWithUserRegError,
            orgData: state.firestore.data.sc_org
        })


}

const mapDispatchToProps = (dispatch) => {
    return {
        registerOrganisations: (org) => dispatch(registerOrganisations(org)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

//export default connect(mapStateToProps, mapDispatchToProps)(AddOrganisation)

export default compose(
    firestoreConnect([
        { collection: 'sc_org' },
        //{ collection: 'sc_org_users' }
    ]), // sync todos collection from Firestore into redux
    connect(mapStateToProps,mapDispatchToProps),
)(AddOrganisation)