import React, { useEffect, useState } from 'react'
import { Layout, Card, Input, Button, message, Spin, Typography } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { signUp } from '../../store/actions/authActions'
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";
const { Content } = Layout;

const { Title } = Typography;

function SignUp(props) {

    let history = useHistory();

    useEffect(() => {
        let secondaryError = true

        if (props.user) {
            message.destroy()
            success()
            history.push("/organizations");
        }
        if (props.error) {
            message.destroy()
            error(props.error);
            message.destroy()
        }

    }, [props.user, props.error])

    const [state, setstate] = useState({
        phoneNumber: '',
        nic: '',
        password: '',
        repeatPassword: '',
        user_type: 'normal',
        numberVerified: true
    })

    function submitDetails() {
        if (state.password && state.repeatPassword && state.nic && state.phoneNumber) {
            if (state.password === state.repeatPassword) {
                if(state.nic.length==9 || state.nic.length==11){
                    if(state.phoneNumber.length===9){
                        props.signUp({
                            phoneNumber: "+94".concat(state.phoneNumber),
                            nic: state.nic,
                            password: state.password,
                        })
                    }else{
                        error('Invalid phone number. Please enter your phone number without the Country Code and the Leading Zero.')
                    }
                }else{
                    error('Invalid NIC Format. Please enter only the numeric part of your NIC number.')
                }
            } else {
                error("Your passwords do not match. Please recheck your passwords.")
            }
        } else {
            error("Please fill out the form to Register.")
        }
    }

    function handleChange(e) {
        setstate({
            ...state,
            [e.target.name]: e.target.value
        })
    }

    const success = () => {
        message.success('You Have Registered Successfully!');
    };

    const error = (err) => {
        message.error(err);
    };

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ minHeight: "100vh" }}>
                <Navbar dimensions={props.dimensions}  direct="SignIn" dir_name="Log In"/>
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title={<Title level={5}>Welcome to Safe In!</Title>}  style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "50px", marginBottom:'10px' , maxHeight: '400px', textAlign: 'center' }}>
                        <div style={{  display: 'flex', justifyContent: 'center', flexDirection: 'column', textAlign: 'left' }}>

                            <div>
                                Phone Number
                                <Input addonBefore="+94" defaultValue="" placeholder="Phone Number"  aria-label="Enter your 9 digit contact number" aria-required="true" value={state.phoneNumber} name='phoneNumber' type='tel' maxLength='9' style={{ marginBottom: '10px', marginTop: '5px'  }} onChange={handleChange} />
                            </div>
                            <div>
                                NIC Number (Numeric Part Only)
                                <Input defaultValue="" placeholder="National Identity Card Number" aria-label="Enter the numeric part of your National Identity Card number" aria-required="true" style={{ marginBottom: '10px', marginTop: '5px'  }} name='nic' value={state.nic} onChange={handleChange} />
                            </div>
                            <div>
                                Password
                                <Input defaultValue="" placeholder="Password" aria-label="Enter your password" aria-required="true" type="password" style={{ marginBottom: '10px', marginTop: '5px'  }} value={state.password} name='password' onChange={handleChange} />
                            </div>
                            <div>
                                Re-Enter Password
                                <Input defaultValue="" placeholder="Re-Enter Password" aria-label="Please re-enter your password" aria-required="true" type="password" style={{ marginBottom: '10px', marginTop: '5px' }} value={state.repeatPassword} name='repeatPassword' onChange={handleChange} />
                            </div>
                            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: "center"}}>
                                <Button type="primary" style={{ width: '150px' }} onClick={submitDetails} data-toggle="tooltip" data-placement="top" title="Register with Safe In">Register</Button>
                            </div>
                        </div>

                        { props.loading  ?
                            <div style={{ display: 'flex', justifyContent: 'flex-start', marginTop: '-25px' }}>
                                <Spin />
                            </div>
                            : null
                        }

                    </Card>
                </Content>
                <BottomFooter />
            </Layout>
        </div >
    )
}

//export default SignUp

const mapStateToProps = ({ auth }) => ({
    loading: auth.signup.loading,
    error: auth.signup.error,
    user: auth.auth.user
});

const mapDispatchToProps = (dispatch) => {
    return {
        signUp: (data) => dispatch(signUp(data))
    }
};

export default connect(mapStateToProps, mapDispatchToProps)(SignUp);


