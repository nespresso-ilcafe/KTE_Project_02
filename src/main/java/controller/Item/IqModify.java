package controller.Item;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ItemDAO;
import dto.ItemQna;


@WebServlet("/item/iqModify")
public class IqModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IqModify() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ItemDAO dao = new ItemDAO();
		
		int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		
		ItemQna iq = dao.oneItemQna(qna_uid, it_uid);
		request.setAttribute("iq", iq);
		
		RequestDispatcher dis = request.getRequestDispatcher("iqModify.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    HttpSession session = request.getSession();

		int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
	    String mb_id = (String) session.getAttribute("id");
	    String category2 = request.getParameter("category2");
	    
	    ItemDAO dao = new ItemDAO();
	    ItemQna iq = new ItemQna();
	    
	    iq.setQna_subject(request.getParameter("qna_subject"));
	    iq.setComment(request.getParameter("comment"));
	    iq.setType1(request.getParameter("type1"));
	    iq.setQna_uid(qna_uid);
	    
	    dao.qnaUpdate(iq);
	    
	    String backUrl = "/item/view?it_uid=" + it_uid + "&category2=" + category2;
	    response.sendRedirect(backUrl);
	}
}
