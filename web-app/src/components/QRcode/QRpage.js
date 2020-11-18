import React, { useEffect } from 'react'
import QRCode from 'qrcode'
//import safeCheckin from "./SafeCheckIn.png"
//import {db} from "./firebase"
import safeCheckin from '../../assets/enter.png'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';
import { Button, Card, Typography } from 'antd';
import * as html2pdf from 'html2pdf.js';
const { Title, Text } = Typography;
function QRpage(props) {



  const baseURL = "https://safecheckin.com";

  useEffect(() => {
    console.log(props.history.location.state.companyDetails)


    if (props.history.location.state.companyDetails) {
      console.log(props.history.location.state.companyDetails)
      const locationDetails = props.history.location.state.companyDetails
      generateQRCode({ canvasId: "canvas", baseURL: baseURL, qrData: { location_type: locationDetails.premise_type, doc_id: locationDetails.location, name: locationDetails.name }, image: { src: safeCheckin, size: 90 } })
    }

  }, [props.history.location.state.companyDetails])

  const generateQRCode = ({ canvasId = "", baseURL = "", qrData = { location_type: "", doc_id: "", name: "" }, qrOptions = { version: 20, errorCorrectionLevel: 'Q' }, image = { src: null, size: 90 } }) => {

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
    const imgDimension = { width: image.size, height: image.size }; //logo dimention
    var context = canvas.getContext('2d');
    var imageObj = new Image();
    imageObj.src = image.src;
    imageObj.onload = function () {
      context.drawImage(imageObj,
        canvas.width / 2 - imgDimension.width / 2,
        canvas.height / 2 - imgDimension.height / 2, imgDimension.width, imgDimension.height);
    };
    const qrDataURL = `${baseURL}/${qrData.location_type}/${qrData.doc_id}?name=${qrData.name}`;

    QRCode.toCanvas(canvas, qrDataURL, {
      version: qrOptions.version,
      errorCorrectionLevel: qrOptions.errorCorrectionLevel
    }, (error) => {
      if (error) console.error(error)
      console.log("QR Code Created Successfully");
    })
  }

  if (props.user == null) return <Redirect to='/signIn' />

  function downloadPdf() {
    var opt = {
      margin: 1,
      filename: 'myfile.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 3 },
      jsPDF: { unit: 'in', format: 'A4', orientation: 'portrait' }
    };
    var element = document.getElementById('qrCoverPage');
    html2pdf().from(element).set(opt).save();
  }

  return (
    <div style={{ width: '100vw', minHeight: '100vh', display: 'flex', justifyContent: 'center', alignItems: "center", flexDirection: 'column' }}>
      <Button type="primary" style={{ marginBottom: '20px' }} onClick={downloadPdf}>Download as PDF</Button>
      <Card id='qrCoverPage' bordered={false} style={{
        width: '590px',
        height: '840px',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
      }}>

        <Card style={{
          width: '563px',
          height: '816px',
          border: '1px solid #000000',
          boxSizing: 'border-box',
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center'
        }}>
          <Card style={{
            width: '561px',
            height: '77px', background: 'rgba(29, 233, 182, 0.23)', display: 'flex', alignItems: 'center', justifyContent: 'center'
          }}>
            <Text strong style={{ textAlign: 'center' }}>Safe Check In & Check Out
            Voluntary Drive to Expose Potential Covid-19 Spread
            Stay Home & Stay Safe
</Text>
          </Card>
          <Title level={4} style={{ textAlign: 'center' }}>Welcome</Title>
          <Title level={4} style={{ textAlign: 'center', color: '#0069AC' }}>{props.history.location.state.companyDetails.name}</Title>
          <canvas id="canvas" style={{ marginLeft: "70px" }}></canvas>
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <Title level={4}>{props.history.location.state.companyDetails.address}</Title>
          </div>
        </Card>
      </Card>




    </div >
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