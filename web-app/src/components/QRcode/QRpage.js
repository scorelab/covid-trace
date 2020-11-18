import React, { useEffect,useState } from 'react'
import QRCode from 'qrcode'
//import safeCheckin from "./SafeCheckIn.png"
//import {db} from "./firebase"
import safeCheckin from '../../assets/enter.png'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom';
import { Button, Card, Typography, Row, Col, Avatar } from 'antd';
import * as html2pdf from 'html2pdf.js';
import enter from '../../assets/enter.png'
import Scansteps from '../../assets/ScanSteps.svg'
import logo from '../../assets/logo.png'
import logoSvg from '../../assets/logoSvg.svg'
const { Title, Text } = Typography;
function QRpage(props) {



  const baseURL = "https://safecheckin.com";
  //const Today = new Date();

  const [state, setstate] = useState({
    date:new Date().toISOString().slice(0,10)
  })

  useEffect(() => {
    console.log(props.history.location.state.companyDetails)


    if (props.history.location.state.companyDetails) {
      console.log(props.history.location.state.companyDetails)
      const locationDetails = props.history.location.state.companyDetails
      console.log(locationDetails.location_type)
      generateQRCode({ canvasId: "canvas", baseURL: baseURL, qrData: { location_type: locationDetails.location_type, doc_id: locationDetails.location, name: locationDetails.name }, image: { src: logoSvg, size: 70 } })
    }
   // console.log(state.date)
  }, [props.history.location.state.companyDetails])

  const generateQRCode = ({ canvasId = "", baseURL = "", qrData = { location_type: "", doc_id: "", name: "" }, qrOptions = { version: 16, errorCorrectionLevel: 'Q' }, image = { src: null, size: 90 } }) => {

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
      margin: 0.25,
      filename: 'qrPageCover.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 3 },
      jsPDF: { unit: 'in', format: 'A4', orientation: 'portrait' }
    };
    var element = document.getElementById('qrCoverPage');
    html2pdf().from(element).set(opt).save();
  }

  return (
    <div style={{ width: '100vw', minHeight: '100vh', display: 'flex', justifyContent: 'center', alignItems: "center", flexDirection: 'column' }}>
      <Button type="primary" style={{ marginBottom: '10px', marginTop: '20px' }} onClick={downloadPdf}>Download as PDF</Button>
      <Card id='qrCoverPage' bordered={false} style={{
        width: '730px',
        height: '1070px',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
      }}>

        <Card style={{
          width: '703px',
          height: '1043px',
          border: '1px solid #000000',
          boxSizing: 'border-box',
          display: 'flex',
          flexDirection: 'column',
          //justifyContent: 'center',
          alignItems: 'center'
        }}>
          <Row style={{ marginTop: '25px' }}>
            <Col span={24} style={{ display: 'flex', justifyContent: 'center' }}>
              <Avatar size="large" src={enter} style={{ float: 'left', marginBottom: '10px', cursor: 'pointer' }} />
              <Title level={1} style={{ textAlign: 'center' }}>Safe In</Title>
            </Col>
          </Row>
          <Row style={{ marginTop: '11px', width: '700px' }}>

            <Card style={{
              width: '100%',
              height: '77px', background: 'rgba(29, 233, 182, 0.23)', display: 'flex', alignItems: 'center', justifyContent: 'center'
            }}>
              <Col span={24} style={{ display: 'flex', justifyContent: 'center' }}>
                <Text strong style={{ textAlign: 'center' }}>Safe In & Safe Out
                Voluntary Drive to Expose Potential Covid-19 Spread
                </Text>
              </Col>
              <Col span={24} style={{ display: 'flex', justifyContent: 'center' }}>
                <Text strong style={{ textAlign: 'center' }}>
                  Stay safe without being traced
                </Text>
              </Col>

            </Card>

          </Row>

          <Title level={1} style={{ textAlign: 'center', marginTop: '10px' }}>Welcome</Title>
          <Title level={2} style={{ textAlign: 'center', color: '#0069AC',marginTop:'-15px' }}>{props.history.location.state.companyDetails.name}</Title>
          <Row>
            <Col span={24} style={{ display: 'flex', justifyContent: 'center',marginTop:'-8px' }}>
              <div >
                <canvas id="canvas" ></canvas>
              </div>
            </Col>
          </Row>
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <Title level={4}>{props.history.location.state.companyDetails.address}</Title>
          </div>
          <Row justify="center" style={{marginTop:'40px',borderBottom:'1px',borderColor:'black'}}>
          <img src={Scansteps} width="600px" />
          </Row>
          <Row justify="center">
          <Title level={3} style={{ textAlign: 'center', marginTop: '10px' }}>Thank You</Title>
          </Row>
          <Row style={{display:'flex',justifyContent:'flex-end'}}>
          <Text  style={{ textAlign: 'end' ,marginBottom:'20px',marginRight:'10px'}}>{state.date}</Text>
          </Row>
 

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