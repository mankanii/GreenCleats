const nodemailer = require("nodemailer");
require("dotenv").config();
// async..await is not allowed in global scope, must use a wrapper
async function sendEmail(email_to, password, role, name) {
  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    service: "Gmail",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: process.env.EMAIL, // generated ethereal user
      pass: process.env.PASSWORD, // generated ethereal password
    },
  });

  let info = transporter.sendMail(
    {
      from: '"Green Cleats" <aadifortest@gmail.com>',
      to: email_to,
      subject: "GreenCleats Team - Approval of" + role + " Account",
      html:
        "<h2>Dear" +
        name +
        ",</h2>" +
        "<p>I am thrilled to inform you that your Ground Owner account on GreenCleats has been approved by our team. You can now access the full range of features and services that we offer to our valued ground owners.</p>" +
        "<p>Your account Email is: <b>" +
        email_to +
        "<p>Your account password is: <b>" +
        password +
        "</b></p>" +
        "<p>Please keep your password safe and secure. If you need any assistance or have any questions, please don't hesitate to reach out to us at support@greencleats.com</p>" +
        "<p>Thank you for choosing GreenCleats, and we look forward to working with you.</p>" +
        "<p>Best regards,</p>" +
        "<p>GreenCleats Team,</p>",
    },
    (err) => {
      if (!err) {
        console.log("No Error");
        return 200;
      } else {
        console.log("error is " + err);
        return 404;
      }
    }
  );
}
async function sendEmailReject(email_to, role, name) {
  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    service: "Gmail",
    port: 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: process.env.EMAIL, // generated ethereal user
      pass: process.env.PASSWORD, // generated ethereal password
    },
  });

  let info = transporter.sendMail(
    {
      from: '"Green Cleats" <aadifortest@gmail.com>',
      to: email_to,
      subject: "Rejection of Green Cleats Account " + role + " Account",
      html:
        "<h2>Dear" +
        name +
        ",</h2>" +
        "<p>I hope this email finds you well. I am writing to inform you that your account application with Green Cleats Team has been rejected.</p>" +
        "<p>After a thorough review of your application, our team has determined that it does not meet our current standards for approval. I regret to inform you that we are unable to provide you with access to our services at this time.</p>" +
        "<p>If you would like to appeal the rejection or have any questions, please do not hesitate to reach out to us. We will be happy to assist you in any way we can.</p>" +
        "<p>Thank you for your understanding and for considering Green Cleats Team for your needs.</p>" +
        "<p>Best regards,</p>" +
        "<p>GreenCleats Team,</p>",
    },
    (err) => {
      if (!err) {
        console.log("No Error");
        return 200;
      } else {
        console.log("error is " + err);
        return 404;
      }
    }
  );
}

module.exports = { sendEmail, sendEmailReject };
