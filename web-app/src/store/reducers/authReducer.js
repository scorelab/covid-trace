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
};

// HELPER FUNCTIONS
const clearAuthReducer = () => {
  return { ...initialState };
};

const signinStart = (state) => {
  return { ...state, signin: { loading: true, error: null } };
};

const signinSuccess = (state, payload) => {
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

const signinEnd = (state) => {
  return { ...state, signin: { ...state.signin, loading: false } };
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

    default:
      return state;
  }
};
