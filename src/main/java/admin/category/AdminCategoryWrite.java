package admin.category;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dto.Category;


@WebServlet("/admin/category/write")
public class AdminCategoryWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminCategoryWrite() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/admin/category/write.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Category c = new Category();
		
		c.setCa_id(request.getParameter("ca_id"));
		c.setCa_name(request.getParameter("ca_name"));
		c.setCa_use(request.getParameter("ca_use"));
		
		CategoryDAO dao = new CategoryDAO();
		dao.insertCategory(c);
		
		response.sendRedirect("list");
	}

}
