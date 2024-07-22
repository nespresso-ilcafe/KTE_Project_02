package controller.orderbbs;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.OrderbbsDAO;
import dto.Orderbbs;

@WebServlet("/orderbbs/orderbbsview")
public class OrderbbsView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderbbsView() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		OrderbbsDAO dao = new OrderbbsDAO();
		
		Orderbbs n = dao.oneNotice(uid);
		
		request.setAttribute("n", n);
		
		if (session.getAttribute("id") == null || !session.getAttribute("id").equals(n.getId())) {
	        response.sendRedirect("/");
	        return;
	    }
		
		RequestDispatcher dis = request.getRequestDispatcher("/orderbbs/orderbbsview.jsp");
		dis.forward(request, response);
	}
}
