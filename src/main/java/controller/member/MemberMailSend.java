package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/member/mailSend")
public class MemberMailSend extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberMailSend() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		
		// 메일 변수
        String mail1 = request.getParameter("mail1");
        String mail2 = request.getParameter("mail2");
        
        String receiver = "";
        if (mail1 != null && !mail1.equals("") && mail2 != null && !mail2.equals("")) {
        	receiver = mail1 + "@" + mail2;
        }
        
        //난수 변수 
        String ran = request.getParameter("result");
        
		//gmail 아이디(메일주소), 앱 비밀번호(2단계 인증) 발급받은 16자리
		String user = "qwertty0901@gmail.com";
		String password = "dqpwglsjcngqqnds";
		
		response.setContentType("text/html; charset=utf-8");
		
		try {
			Properties p = new Properties(); //서버 정보를 p객체에 저장
			
			p.put("mail.smtp.starttls.enable","true");
			p.put("mail.smtp.host","smtp.gmail.com"); //gmail.com
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.port", "587"); //gmail 포트번호
			
			//인증정보 생성
			Session s = Session.getInstance(p, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});

			Message m = new MimeMessage(s); //s객체를 사용하여 전송할 m객체 생성
			
			Address receiver_address = new InternetAddress(receiver); //받는 사람

			//메일 전송에 필요한 설정 부분
			m.setHeader("content-type", "text/html;charset=utf-8");
			m.addRecipient(Message.RecipientType.TO, receiver_address);
			m.setSubject("야입구문 가입 인증메일입니다.");
			m.setContent("인증번호는 "+ran+"입니다.", "text/html;charset=utf-8");
			m.setSentDate(new Date());
			
			Transport.send(m); //메세지를 메일로 전송
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
