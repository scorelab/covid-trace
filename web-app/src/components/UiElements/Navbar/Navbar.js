import React, { useEffect } from 'react'
import enter from '../../../assets/enter.png'
import family from '../../../assets/family.png'
import { connect } from 'react-redux'
import { Button, Layout, Typography, Avatar, Row, Col } from 'antd';
import SignedLinks from './SignedLinks';
import { useHistory } from "react-router-dom";
import { Link } from "react-router-dom";

const { Header } = Layout;
const { Title, Text } = Typography;


function Navbar(props) {
    const { user } = props

    let history = useHistory();

    function goToHome() {
        if (user) {
            history.push("/organizations");
        } else {
            history.push("/");
        }
    }
    useEffect(() => {
            const script = document.createElement("script");
            script.id = "translator"
            script.src = "//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit";
            script.type = "text/javascript"
            script.async = true
            document.body.appendChild(script);
    
    }, [])
    return (
        <div>
            <Header style={{ background: '#F9F9F9', boxShadow: '0px 1px 4px rgba(0, 0, 0, 0.25)', height: '60px', paddingTop: "5px", paddingLeft: "20px", display: "flex", alignItems: 'center' }}>
                <Row style={{ display: 'flex', alignItems: 'center', width: '100%' }}>
                    <Col xs={12} sm={12} md={16} >
                        <Avatar size="large" src={enter} style={{ float: 'left', marginBottom: '10px', cursor: 'pointer' }} onClick={goToHome} alt="Safe-in Logo" data-toggle="tooltip" data-placement="top" title="Go to Safe In - Home"/>
                        <Title level={3} style={{ marginTop: "10px", marginLeft: '-10px', cursor: 'pointer' }} onClick={goToHome} data-toggle="tooltip" data-placement="top" title="Go to Safe In - Home"> SAFE IN</Title>
                    </Col>
                    {
                        (user) ? <SignedLinks dimensions={props.dimensions} /> :
                            <Col xs={12} sm={12} md={8} style={{ display: "flex", justifyContent: "flex-end", alignItems: "center" }}>
                                <Link to={props.direct}>
                                    <Button
                                        type="primary"
                                        style={{ width: '140px' }}
                                    >
                                        {props.dir_name}
                                    </Button>
                                </Link>
                            </Col>
                    }

                </Row>
            </Header>
            <Header style={{ background: 'rgba(29, 233, 182, 0.23)', height: props.dimensions.width > 770 ? '50px' : '65px', display: 'flex', alignItems: "center", paddingLeft: "20px", lineHeight: "11px"}}>
                <Row style={{ width: '100%', padding: '2px 0px 5px 2px' }}>
                    <Col xs={24} md={12} style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', 
                    justifyContent: props.dimensions.width > 770 ? 'start' : 'center' }}>
                        <Avatar size={30} src={family} style={{ float: 'left', marginTop: "2px" }} alt="picture of a family" />
                        <Text style={{ color: "#626262", marginLeft: "5px", marginTop: "2px" }}>Stay safe without being traced</Text>
                    </Col>
                    <Col xs={24} md={12} style={{ display: 'flex', flexDirection: 'row', alignItems: 'center',  justifyContent: props.dimensions.width > 770 ? 'flex-end' : 'center'}}>
                        <div id="google_translate_element"></div>
                    </Col>
                </Row>
            </Header>
        </div>
    )
}

const mapStateToProps = (state) => {
    //console.log(state)
    //console.log(state)
    return {
        user: state.auth.auth.user
    }
}

export default connect(mapStateToProps)(Navbar)

