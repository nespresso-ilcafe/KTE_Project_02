package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/member/pass_ok")
public class MemberOkPass extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberOkPass() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pass = request.getParameter("pass");
		String msg = "";
		
		int num = 0;
		if(pass.length() < 6) {
			msg = "1";
			num = 1;
		}else if(pass.length() >= 20) {
			msg = "2";
			num = 2;
		}else if(!Pattern.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#%^&*]).{6,20}$", pass)) {
			msg = "3";
			num = 3;
		}
		
		response.setContentType("html/text; charset=utf-8"); // 출력구문 한글 깨짐 방지
		PrintWriter out = response.getWriter();
		out.print(msg);
	}
}
