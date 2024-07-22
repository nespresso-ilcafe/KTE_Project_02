package admin.category;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dto.Category;

@WebServlet("/admin/category/modify")
public class AdminCategoryModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminCategoryModify() {
        super();

    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String ca_id = request.getParameter("ca_id");
		String ca_name = request.getParameter("ca_name");
		String ca_use = request.getParameter("ca_use");
		
		Category c = new Category();
		
		c.setCa_id(ca_id);
		c.setCa_name(ca_name);
		c.setCa_use(ca_use);
		
		CategoryDAO dao = new CategoryDAO();
		dao.updateCategory(c);
		
		response.sendRedirect("list");
	}

}
