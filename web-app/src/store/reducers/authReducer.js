import * as actions from '../actions/actionTypes';

const initialState = {
  signin: {
    error: null,
    loading: false,
  },
  auth: {
    user: null,
    authenticated: true,
  },
  signup: {
    error: null,
    loading: false
  }
};

// HELPER FUNCTIONS
const clearAuthReducer = () => {
  return { ...initialState };
};

const signinStart = (state) => {
  return { ...state, signin: { loading: true, error: null } };
};

const signUpStart = (state) => {
  return { ...state, signup: { loading: true, error: null }, signin: { loading: true, error: null } };
};

const signinSuccess = (state, payload) => {
  return { ...state, auth: { user: payload, authenticated: true } };
};

const signUpSuccess = (state, payload) => {
  return { ...state, auth: { user: payload, authenticated: true } };
};

const signinFail = (state, payload) => {
  return {
    ...state,
    signin: { error: payload },
    auth: {
      user: null,
      authenticated: true,
    },
  };
};

const signUpFail = (state, payload) => {
  return {
    ...state,
    signup: { error: payload },
    signin: { error: payload },
    auth: {
      user: null,
      authenticated: true,
    },
  };
};

const signinEnd = (state) => {
  return { ...state, signin: { ...state.signin, loading: false } };
};

const signupEnd = (state) => {
  return { ...state, signin: { ...state.signin, loading: false }, signup: { ...state.signup, loading: false } };
};

export default (state = initialState, { type, payload }) => {
  switch (type) {
    case actions.SIGNIN_START:
      return signinStart(state);

    case actions.SIGNIN_SUCCESS:
      return signinSuccess(state, payload);

    case actions.SIGNIN_FAIL:
      return signinFail(state, payload);

    case actions.SIGNIN_END:
      return signinEnd(state);

    case actions.SIGN_UP_START:
      return signUpStart(state);

    case actions.SIGN_UP_SUCCESS:
      return signUpSuccess(state, payload);

    case actions.SIGN_UP_FAIL:
      return signUpFail(state, payload);

      case actions.SIGN_UP_END:
        return signupEnd(state);

    case actions.SIGNOUT_SUCCESS:
      console.log("Sign Out Success")
      return initialState
    default:
      return state;
  }
};
