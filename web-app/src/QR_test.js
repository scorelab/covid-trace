import React, {Component} from "react"
import QRCode from 'qrcode'
import safeCheckin from "./SafeCheckIn.png"
import {db} from "./firebase"
 


class QR_test extends Component {

  baseURL = "https://safecheckin.com";
  generateQRCode = ({canvasId = "", baseURL="", qrData = {location_type: "", doc_id: "", name: ""}, qrOptions = {version: 20, errorCorrectionLevel: 'Q'}, image = {src: null, size: 90}}) => {

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
  componentDidMount(){
    
    db.collection("sc_bus").get().then(snapShot => {
      console.log(snapShot);
      snapShot.forEach(doc => {
        console.log(doc.data());

        this.generateQRCode({canvasId:"canvas", baseURL: this.baseURL, qrData: {location_type: "sc_bus", doc_id: doc.id, name: doc.data().name}, image: {src: safeCheckin, size: 90}})
      });
    }).catch(err => {
      console.log(err);
    });
  
  }
  render() {
    return (
      <div>
        <h1>QR Test</h1>
      
      {/* <img src={this.url}/> */}

      <canvas id="canvas"></canvas>
      </div>
      );
  }
}

export default QR_test;
