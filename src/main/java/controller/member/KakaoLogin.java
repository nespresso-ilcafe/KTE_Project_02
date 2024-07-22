package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;

@WebServlet("/member/kakao")
public class KakaoLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public KakaoLogin() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String signdate = sdf.format(today);
    	
    	String id = request.getParameter("useremail");
        MemberDAO dao = new MemberDAO();
        PrintWriter out = response.getWriter();
        //jsp페이지로 값을 전달하기 위함
        
        int num = dao.loginOk(id);
        if (num == 1) {
        	//이미 가입되어있다면 로그인처리
            Member m = dao.oneMember(id);
            
            HttpSession session = request.getSession();

            session.setAttribute("id", m.getId());
            session.setAttribute("name", m.getName());
            session.setAttribute("connecttype", m.getConnecttype());
            session.setAttribute("level", m.getLevel());
            
            if(m.getName().equals("카카오로그인")) {
            	out.print("2");
            	//이름이 카카오로그인이라면 2를 전달
            }else {
            	out.print("1");
            	//이름이 카카오로그인이 아니라면 1를 전달
            }
        } else {
            //회원가입이 안되어있을때 회원가입 처리
            dao.insertMemberApi(id,signdate);

            HttpSession session = request.getSession();

            session.setAttribute("id", id);
            session.setAttribute("name", "카카오로그인");
            session.setAttribute("connecttype", "카카오");
            session.setAttribute("level", "1");
            session.setAttribute("signdate", signdate);
        }
    }
}
