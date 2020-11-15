import React, { useEffect, useState } from 'react'
import { Layout, Card, Input, Button, message } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';
import { registerOrganisations } from '../../store/actions/registrationActions';
import { useHistory } from "react-router-dom";
const { Content } = Layout;

function AddOrganisation(props) {

    let history = useHistory();

    useEffect(() => {
    
         if (props.orgRegError) {
            error();
        } else if(props.orgRegError===false) {
                success();
                props.reset();
                history.push("/organisations");
        } 
    },[props.orgRegError])


    const [state, setstate] = useState({
        Name: '',
        UserName: '',
        WebSite: ''
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
        props.registerOrganisations({
            ...state,
            phoneNumber:props.user.phoneNumber
        })
    }

    const error = () => {
        message.error('Error');
    };

    const success = () => {
        message.success('Registration Completed');
    };


    if (props.user == null) return <Redirect to='signIn' />
    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar />
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Add New Organisation" style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "131px", height: '290px' }}>
                        <div style={{ margin: "5px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>

                            <Input defaultValue="" placeholder="Organisation Name" name="Name" style={{ marginBottom: '10px' }} onChange={handleChange} />
                            <Input defaultValue="" placeholder="Organisation UserName" name="UserName" style={{ marginBottom: '10px' }} onChange={handleChange} />
                            <Input defaultValue="" placeholder="Website URL" name="WebSite" style={{ marginBottom: '10px' }} onChange={handleChange} />

                            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: "center", paddingTop: '10px' }}>
                                <Button type="primary" style={{ width: "150px" }} onClick={handleSubmit}>Add</Button>
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
            orgWithUserRegError: state.Registration.orgWithUserRegError
        })


}

const mapDispatchToProps = (dispatch) => {
    return {
        registerOrganisations: (org) => dispatch(registerOrganisations(org)),
        reset: () => dispatch({ type: 'RESET' })
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(AddOrganisation)

