import * as sha256 from 'sha256';
import * as actions from './actionTypes';

/**
 * If new action is created please update this list
 * ================================================
 * Sign in
 * ================================================
 */

/**  Login action creator
 * @function
 * @param {object} data - Sign In data
 * @param {object} history - this.props.history
 * */
export const signIn = (data, history) => async (
  dispatch,
  getState,
  { getFirebase, getFirestore }
) => {
  const firestore = getFirestore();

  dispatch({ type: actions.SIGNIN_START });

  if(data.phoneNumber.length!=12){
    dispatch({ type: actions.SIGNIN_FAIL, payload: 'Invalid phone number' });
    dispatch({ type: actions.SIGNIN_END });
    return;
  }

  const users = firestore.collection('users');

  const hashedPassword = sha256(data.password);

  const usersQs = await users
    .where('phoneNumber', '==', data.phoneNumber ?? '')
    .get()
    .catch((e) => {
      dispatch({ type: actions.SIGNIN_FAIL });
      dispatch({ type: actions.SIGNIN_END });
    });

  if (usersQs.size > 0 && usersQs.docs[0].exists) {
    const documentSnapshot = usersQs.docs[0];
    const user = documentSnapshot.data();
    if (user.password === hashedPassword) {
      dispatch({ type: actions.SIGNIN_SUCCESS, payload: user });
      dispatch({ type: actions.SIGNIN_END });
    } else {
      dispatch({ type: actions.SIGNIN_FAIL, payload: 'wrong password' });
      dispatch({ type: actions.SIGNIN_END });
    }
  } else {
    dispatch({ type: actions.SIGNIN_FAIL, payload: 'user not found' });
    dispatch({ type: actions.SIGNIN_END });
  }
};

export const signOut = (data, history) => async (
  dispatch,
  getState,
  { getFirebase, getFirestore }
) => {
  const firebase = getFirebase();
  //console.log("First")
  firebase.auth().signOut().then(() => {
    dispatch({ type: actions.SIGNOUT_SUCCESS })
  })

};


export const signUp = (data, history) => async (
  dispatch,
  getState,
  { getFirebase, getFirestore }
) => {

  const firestore = getFirestore();
  console.log(data.phoneNumber)
  const users = firestore.collection('users');

  dispatch({ type: actions.SIGN_UP_START })

  const password = sha256(data.password);
  const nic = sha256(data.nic);

  const usersQs = await users
    .where('phoneNumber', '==', data.phoneNumber ?? '')
    .get()
    .catch((e) => {
      //dispatch({ type: actions.SIGNIN_FAIL });
      //  dispatch({ type: actions.SIGNIN_END });
    });

  console.log(usersQs.docs[0])

  if (usersQs.size > 0) {
    dispatch({ type: actions.SIGN_UP_FAIL, payload: 'Phone is existing on the system, Pls enter another number' })
    dispatch({ type: actions.SIGN_UP_END })
  } else {
    users.add({
      nic,
      numberVerified: true,
      password,
      phoneNumber: data.phoneNumber,
      user_type: 'normal'
    }).then(() => {
      dispatch({
        type: actions.SIGN_UP_SUCCESS, payload: {
          nic,
          numberVerified: true,
          phoneNumber: data.phoneNumber,
          user_type: 'normal'
        }
      });
      dispatch({ type: actions.SIGN_UP_END });
    }).catch((err) => {
      dispatch({ type: actions.SIGN_UP_FAIL, payload: 'error' });
      dispatch({ type: actions.SIGNIN_END });
    })
  }
};

