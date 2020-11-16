import React from 'react'
import { Button, Col } from 'antd';
import { UserOutlined, LogoutOutlined } from '@ant-design/icons';
import { Link, useHistory } from "react-router-dom";
import { connect } from 'react-redux'
import {signOut} from '../../../store/actions/authActions';


function SignedLinks(props) {

    let history = useHistory();

    function goToPath(path) {
        history.push(path);
    }

    return (

        <Col xs={24} sm={24} md={8} style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
            <Link to="/registration">
                <Button type="primary" style={{ marginRight: '20px' }} >Add Your Location</Button>
            </Link>
            <Link to="/addOrganisation">
                <Button type="primary" style={{ marginRight: '20px' }}>Organisations</Button>
            </Link>
            <UserOutlined style={{ fontSize: '30px', marginRight: '20px' }} onClick={() => goToPath('/userProfile')} />
            <LogoutOutlined style={{ fontSize: '30px' }} onClick={props.signOut}/>
        </Col>

    )
}


const mapDispatchToProps = (dispatch) => {
    return {
        signOut: () => dispatch(signOut())
    }
}


export default connect(null,mapDispatchToProps)(SignedLinks)


