package admin.banner;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BannerDAO;

@WebServlet("/admin/banner/bannerdelete")
public class BannerDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BannerDelete() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		BannerDAO dao = new BannerDAO();
		dao.oneDelete(uid);
		
		response.sendRedirect("bannerlist");
	}


}
