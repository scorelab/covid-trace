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
          <li onClick={() => goToPath('/addOrganisation')} data-toggle="tooltip" data-placement="top" title="Add new organization">
            <Link to="" >
                Add Organization
            </Link>
          </li>
          <li onClick={() => goToPath('/registration')} data-toggle="tooltip" data-placement="top" title="Add an entity belonging to your organization">
            <Link to="">
                Add Entity
            </Link>
          </li>
          <li onClick={() => goToPath('/userProfile')} data-toggle="tooltip" data-placement="top" title="View profile">
            <Link to="">
              <UserOutlined style={{ fontSize: '15px'}} /> My profile
            </Link>
          </li> 
          <li onClick={props.signOut} data-toggle="tooltip" data-placement="top" title="Log out">
            <Link to="">
              <LogoutOutlined style={{ fontSize: '15px' }} /> Log out
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
