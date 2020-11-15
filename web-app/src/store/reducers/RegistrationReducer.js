
const initstate={
    registrationError:null,
    orgRegError:null,
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
        case 'ORG_REGISTRATION_SUCCESS':
            console.log('Registration Is successfull',action)
            return {
                ...state,
                orgRegError:false
            }
        case 'ORG_REGISTRATION_ERROR':
            console.log('Error',action.err)
            return{
                ...state,
                orgRegError:true
            }
        default:
            console.log("default")
            return{
                ...state,
                orgRegError:null,
                registrationError:null,
            }
    }
} 

export default RegistrationReducer;