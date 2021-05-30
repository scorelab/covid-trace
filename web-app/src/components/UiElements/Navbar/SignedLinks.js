import React, { useEffect, useState, useRef } from 'react'
import { Button, Col } from 'antd';
import { UserOutlined, LogoutOutlined, MenuOutlined, CloseOutlined } from '@ant-design/icons';
import DropDown from './DropDown';
import { Link, useHistory } from "react-router-dom";
import { connect } from 'react-redux'
import {signOut} from '../../../store/actions/authActions';

function SignedLinks(props) {

    let history = useHistory();

    function goToPath(path) {
        history.push(path);
    }
    const [dimensions, setDimensions] = React.useState({ 
        height: window.innerHeight,
        width: window.innerWidth
      })
      
    const [dropdown, setDropdown] = useState(false);
    const ref_drop = useRef(null);
    const ref_btn = useRef(null);


    const showDropDown = () => {
            setDropdown(!dropdown);
      };

    const handleClickOutside = (event) => {
        if (ref_drop.current && !ref_drop.current.contains(event.target) && !ref_btn.current.contains(event.target) && dropdown) {
            setDropdown(false);
        }
    };


    useEffect(() => {
        function handleResize() {
          setDimensions({
            height: window.innerHeight,
            width: window.innerWidth
          })
        }
        window.addEventListener('resize', handleResize)
        window.addEventListener('click', handleClickOutside);
        return _ => {
            window.removeEventListener('resize', handleResize)
            window.removeEventListener('click', handleClickOutside);
        }
    })


    return (
        (dimensions.width > 615)?
        <Col xs={12} sm={12} md={8} style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
            <Link to="/addOrganisation">
                <Button type="primary" style={{ marginRight: '20px' }} data-toggle="tooltip" data-placement="top" title="Add new organization">Add Organization</Button>
            </Link>
            <Link to="/registration">
                <Button type="primary" style={{ marginRight: '20px' }} data-toggle="tooltip" data-placement="top" title="Add an entity belonging to your organization">Add Entity</Button>
            </Link>
            <UserOutlined style={{ fontSize: '30px', marginRight: '20px' }} onClick={() => goToPath('/userProfile')} data-toggle="tooltip" data-placement="top" title="View profile" />
            <LogoutOutlined style={{ fontSize: '30px' }} onClick={props.signOut} data-toggle="tooltip" data-placement="top" title="Log out" />
        </Col>:
        <Col xs={12} sm={12} md={8} style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center' }}>
            <Button onClick={showDropDown} type="primary" style={{ marginRight: '20px' }} ref={ref_btn}>
                Menu {(dropdown)?<CloseOutlined />:<MenuOutlined />}
            </Button> 
            {dropdown && <DropDown innerref={ref_drop}/>}
        </Col>
    )
}


const mapDispatchToProps = (dispatch) => {
    return {
        signOut: () => dispatch(signOut())
    }
}


export default connect(null,mapDispatchToProps)(SignedLinks)


