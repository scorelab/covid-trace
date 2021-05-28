import {persistStore, persistReducer  } from "redux-persist";
import { getFirebase, reactReduxFirebase } from 'react-redux-firebase';
import { applyMiddleware, compose, createStore } from 'redux';
import { getFirestore, reduxFirestore } from 'redux-firestore';
import storage from 'redux-persist/lib/storage'
import thunk from 'redux-thunk';
import { f } from '../config/config_env';
import rootReducer from './reducers';

const persistConfig = {
  key : 'root',
  storage,
}

const persistedReducer = persistReducer(persistConfig, rootReducer);

// react-redux-firebase config
const rrfConfig = {
  userProfile: 'users',
  useFirestoreForProfile: true, // Firestore for Profile instead of Realtime DB
  attachAuthIsReady: true, // attaches auth is ready promise to store
};

//show redux dev tools only in dev env
const composeEnhancers =
  process.env.NODE_ENV === 'development'
    ? window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose
    : compose;

const store = createStore(
  persistedReducer,
  composeEnhancers(
    reactReduxFirebase(f, rrfConfig),
    reduxFirestore(f),
    applyMiddleware(thunk.withExtraArgument({ getFirebase, getFirestore }))
  )
);

const persistor = persistStore(store);

export default {store, persistor};
// const store = createStore(
//   rootReducer,
//   composeEnhancers(
//     reactReduxFirebase(f, rrfConfig),
//     reduxFirestore(f),
//     applyMiddleware(thunk.withExtraArgument({ getFirebase, getFirestore }))
//   )
// );

//export default store;
