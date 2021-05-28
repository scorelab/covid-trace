import React, { useEffect, useState } from 'react'
import { Layout, Card, Input, Button, message, Spin } from 'antd';
import Navbar from '../UiElements/Navbar/Navbar';
import BottomFooter from '../UiElements/BottomFooter';
import { signUp } from '../../store/actions/authActions'
import { connect } from 'react-redux'
import { useHistory } from "react-router-dom";
const { Content } = Layout;

function SignUp(props) {

    let history = useHistory();

    useEffect(() => {
        let secondaryError = true

        if (props.user) {
            message.destroy()
            success()
            //history.push("/organizations");
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
                        error('Phone No Format Wrong')
                    }
                }else{
                    error('NIC Format Wrong')
                }
            } else {
                error("Please Re enter password again")
            }
        } else {
            error("Please Fill all these details")
        }
    }

    function handleChange(e) {
        setstate({
            ...state,
            [e.target.name]: e.target.value
        })
    }

    const success = () => {
        message.success('You Have Registered Successfully');
    };

    const error = (err) => {
        message.error(err);
    };

    return (
        <div style={{ background: "#F2F2F2" }}>
            <Layout style={{ height: "100vh" }}>
                <Navbar  direct="SignIn" dir_name="Log In"/>
                <Content style={{ padding: '0 50px', display: 'flex', justifyContent: 'center' }}>
                    <Card title="Welcome" style={{ width: 475, boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)', marginTop: "131px", height: '330px' }}>
                        <div style={{ margin: "10px 0px 52px", display: 'flex', justifyContent: 'center', flexDirection: 'column' }}>
                            <Input addonBefore="+94" defaultValue="" placeholder="Contact No"  aria-label="Enter your 9 digit contact number" aria-required="true" value={state.phoneNumber} name='phoneNumber' type="number" style={{ marginBottom: '10px' }} onChange={handleChange} />
                            <Input defaultValue="" placeholder="NIC" aria-label="Enter your 9 digit National Identity Card number" aria-required="true" style={{ marginBottom: '10px' }} name='nic' type="number" value={state.nic} onChange={handleChange} />
                            <Input defaultValue="" placeholder="Password" aria-label="Enter a password" aria-required="true" type="password" style={{ marginBottom: '10px' }} value={state.password} name='password' onChange={handleChange} />
                            <Input defaultValue="" placeholder="Reenter Password" aria-label="Reenter the password" aria-required="true" type="password" style={{ marginBottom: '10px' }} value={state.repeatPassword} name='repeatPassword' onChange={handleChange} />
                            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: "center", paddingTop: '20px' }}>
                                <Button type="primary" style={{ width: '150px' }} onClick={submitDetails}>Register</Button>
                            </div>
                        </div>

                        {props.loading ?
                            <div style={{ display: 'flex', justifyContent: 'flex-start', marginTop: '-75px' }}>
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


