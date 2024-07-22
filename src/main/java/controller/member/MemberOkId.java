package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import dto.Member;


@WebServlet("/member/id_ok")
public class MemberOkId extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberOkId() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String msg = "";
		
		MemberDAO dao = new MemberDAO();
		int num = dao.loginOk(id); //존재여부 확인
		
		if(id.length() < 5) {
			msg = "5";
		}else if(num == 1) {
			msg = "1";
		}else if(num == 0) {
			msg = "0";
		}
		
		response.setContentType("html/text; charset=utf-8"); // 출력구문 한글 깨짐 방지
		PrintWriter out = response.getWriter();
		out.print(msg);
	}
}
