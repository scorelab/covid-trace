export const registerBusiness = (business) =>{
    return (dispatch,getState,{getFirebase,getFirestore})=>{
        const firestore = getFirestore();
        console.log(business)
        firestore.collection('sc_location').add({
            ...business
        }).then(()=>{
            dispatch({type:'REGISTRATION_SUCCESS',business});
        }).catch((err)=>{
            dispatch({type:'REGISTRATION_ERROR',err});
        })
    }
}

export const registerBus = (bus) =>{
    return (dispatch,getState,{getFirebase,getFirestore})=>{
        const firestore = getFirestore();
        console.log(bus)
        firestore.collection('sc_bus').add({
            ...bus
        }).then(()=>{
            dispatch({type:'REGISTRATION_SUCCESS',bus});
        }).catch((err)=>{
            dispatch({type:'REGISTRATION_ERROR',err});
        })
    }
}

export const registerTrain = (train) =>{
    return (dispatch,getState,{getFirebase,getFirestore})=>{
        const firestore = getFirestore();
        console.log(train)
        firestore.collection('sc_train').add({
            ...train
        }).then(()=>{
            dispatch({type:'REGISTRATION_SUCCESS',train});
        }).catch((err)=>{
            dispatch({type:'REGISTRATION_ERROR',err});
        })
    }
}

export const registerVehicle = (vehicle) =>{
    return (dispatch,getState,{getFirebase,getFirestore})=>{
        const firestore = getFirestore();
        console.log(vehicle)
        firestore.collection('sc_vehicle').add({
            ...vehicle
        }).then(()=>{
            dispatch({type:'REGISTRATION_SUCCESS',vehicle});
        }).catch((err)=>{
            dispatch({type:'REGISTRATION_ERROR',err});
        })
    }
}