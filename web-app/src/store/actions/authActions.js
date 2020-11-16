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
 firebase.auth().signOut().then(()=>{
   dispatch({type:actions.SIGNOUT_SUCCESS})
 })
 
};

