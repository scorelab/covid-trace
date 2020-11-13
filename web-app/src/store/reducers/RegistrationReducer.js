
const initstate={
    registrationError:null
}

const RegistrationReducer = (state=initstate,action)=>{
    switch(action.type){
        case 'REGISTRATION_SUCCESS':
            console.log('Registration Is successfull',action)
            return {
                ...state,
                registrationError:false
            }
        case 'REGISTRATION_ERROR':
            console.log('Error',action.err)
            return{
                ...state,
                registrationError:true
            }
        default:
            return{
                ...state,
                registrationError:null
            }
    }
} 

export default RegistrationReducer;