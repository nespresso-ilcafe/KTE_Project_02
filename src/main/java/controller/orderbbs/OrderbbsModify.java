package controller.orderbbs;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderbbsDAO;
import dto.Orderbbs;

@WebServlet("/orderbbs/orderbbsmodify")
public class OrderbbsModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderbbsModify() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		OrderbbsDAO dao = new OrderbbsDAO();
		Orderbbs n = dao.oneNotice(uid);
		
		request.setAttribute("n", n);
		
		RequestDispatcher dis = request.getRequestDispatcher("orderbbsmodify.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		Orderbbs n = new Orderbbs();
	      
		n.setUid(uid);
	    n.setSubject(request.getParameter("subject"));
	    n.setComment(request.getParameter("comment"));
		
		OrderbbsDAO dao = new OrderbbsDAO();
		dao.updateNotice(n);
		
		response.sendRedirect("orderbbslist");
	}
}
