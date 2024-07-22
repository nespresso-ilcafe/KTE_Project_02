package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dto.Member;

@WebServlet("/member/join")
public class MemberJoin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MemberJoin() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dis = request.getRequestDispatcher("join.jsp");
        dis.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // POST 데이터의 인코딩을 UTF-8로 설정

        Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String signdate = sdf.format(today);

        // 생년월일 변수
        String bir1 = request.getParameter("mb_bir1");
        String bir2 = request.getParameter("mb_bir2");
        String bir3 = request.getParameter("mb_bir3");
        String bir = bir1 + "-" + bir2 + "-" + bir3;

        // 폰번호 변수
        String pn1 = request.getParameter("mb_pn1");
        String pn2 = request.getParameter("mb_pn2");
        String pn3 = request.getParameter("mb_pn3");
        String pn = pn1 + "-" + pn2 + "-" + pn3;

        // 메일 변수
        String mail1 = request.getParameter("mb_email1");
        String mail2 = request.getParameter("mb_email2");
        String mail3 = request.getParameter("mb_email3");

        String email = "";
        if (mail2 != null && !mail2.isEmpty()) {
            email = mail1 + "@" + mail2;
        }
        
        Member m = new Member();
        // 인서트 문
        m.setId(request.getParameter("mb_id"));
        m.setPass(request.getParameter("mb_pass"));
        m.setName(request.getParameter("mb_name"));
        m.setBirth(bir);
        m.setPn(pn);
        m.setEmail(email);
        m.setZc(request.getParameter("mb_zc"));
        m.setZc1(request.getParameter("mb_zc1"));
        m.setZc2(request.getParameter("mb_zc2"));
        m.setZc3(request.getParameter("mb_zc3"));
        m.setZc4(request.getParameter("mb_zc4"));
        m.setGender(request.getParameter("mb_gender"));
        m.setSigndate(signdate);
        m.setConnecttype("로컬");
        m.setLevel("1");
        m.setStatus("정상");

        MemberDAO dao = new MemberDAO();

        dao.MemberInsert(m);
        
        response.setContentType("text/html; charset=utf-8");
      PrintWriter out = response.getWriter();
      
      out.println("<script>alert('회원가입이 완료되었습니다.');window.location.href='/';</script>");
    }
}