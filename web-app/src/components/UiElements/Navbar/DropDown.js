import React from 'react'
import { UserOutlined, LogoutOutlined, MenuOutlined } from '@ant-design/icons';
import { Link, useHistory } from "react-router-dom";
import { connect } from 'react-redux'
import {signOut} from '../../../store/actions/authActions';
import './DropDown.css';

function DropDown (props) {
    let history = useHistory();

    function goToPath(path) {
        history.push(path);
    }
  
    return (
        <ul
          className={'dropdown-menu'} ref = {props.innerref}
        >
          <li onClick={() => goToPath('/addOrganisation')}>
            <Link to="" >
                Add Organizations
            </Link>
          </li>
          <li onClick={() => goToPath('/registration')}>
            <Link to="">
                Add Your Location
            </Link>
          </li>
          <li onClick={() => goToPath('/userProfile')} >
            <Link to="">
              <UserOutlined style={{ fontSize: '15px'}} /> My profile
            </Link>
          </li> 
          <li onClick={props.signOut} >
            <Link to="">
              <LogoutOutlined style={{ fontSize: '15px' }} /> Sign out
            </Link>
          </li>
        </ul>
    );
  
  }

const mapDispatchToProps = (dispatch) => {
    return {
        signOut: () => dispatch(signOut())
    }
}

export default connect(null,mapDispatchToProps)(DropDown)
