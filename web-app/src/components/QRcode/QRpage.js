import React, { useEffect } from 'react'
import QRCode from 'qrcode'
//import safeCheckin from "./SafeCheckIn.png"
//import {db} from "./firebase"
import safeCheckin from '../../assets/enter.png'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';

function QRpage(props) {

   

    const baseURL = "https://safecheckin.com";

    useEffect(()=>{
        console.log(props.history.location.state.companyDetails)

        
        if(props.history.location.state.companyDetails){
            const locationDetails = props.history.location.state.companyDetails
            generateQRCode({canvasId:"canvas", baseURL: baseURL, qrData: {location_type: locationDetails.premise_type, doc_id: locationDetails.location, name: locationDetails.name}, image: {src: safeCheckin, size: 90}})
        }
           
    },[props.history.location.state.companyDetails])

    const generateQRCode = ({canvasId = "", baseURL="", qrData = {location_type: "", doc_id: "", name: ""}, qrOptions = {version: 20, errorCorrectionLevel: 'Q'}, image = {src: null, size: 90}}) => {
  
      // Debug
      console.log({
        canvasId,
        baseURL,
        qrData,
        qrOptions,
        image
      })
      // Refer the Canvas Element
      let canvas = document.getElementById(canvasId);
  
      // Center Image    
      const imgDimension={width:image.size,height:image.size}; //logo dimention
      var context = canvas.getContext('2d');
      var imageObj = new Image();  
      imageObj.src = image.src;      
      imageObj.onload = function() {
        context.drawImage(imageObj, 
        canvas.width / 2 - imgDimension.width / 2,
        canvas.height / 2 - imgDimension.height / 2,imgDimension.width,imgDimension.height);
      };
      const qrDataURL = `${baseURL}/${qrData.location_type}/${qrData.doc_id}?name=${qrData.name}`;
  
      QRCode.toCanvas(canvas, qrDataURL, {
        version: qrOptions.version,
        errorCorrectionLevel: qrOptions.errorCorrectionLevel
      },  (error) => {
        if (error) console.error(error)
        console.log("QR Code Created Successfully");
      })
    }

    if (props.user == null) return <Redirect to='/signIn' />
    
    return (
        <div style={{width:'100vw',height:'100vh',display:'flex',justifyContent:'center',alignItems:"center",flexDirection:'column',marginTop:'-100px'}}>
            <h1>QR Test</h1>

            {/* <img src={this.url}/> */}

            <canvas id="canvas"></canvas>
        </div>
    )
}


const mapStateToProps = (state) => {
    //console.log(state)
    return ({
        ...state,
        user: state.auth.auth.user
    })
}


export default connect(mapStateToProps)(QRpage)