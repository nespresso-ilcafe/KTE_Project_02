package controller.Item;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import dto.Item;
import dto.ItemQna;


@WebServlet("/item/iqviews")
public class IqViews extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IqViews() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ItemDAO dao = new ItemDAO();
		
		int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		String category2 = request.getParameter("category2");

		Item it = dao.oneItem(it_uid);
		request.setAttribute("it", it);
		
		ItemQna iq = dao.oneItemQna(qna_uid, it_uid);
		request.setAttribute("iq", iq);
		
		RequestDispatcher dis = request.getRequestDispatcher("iqviews.jsp");
		dis.forward(request, response);
	}
}
