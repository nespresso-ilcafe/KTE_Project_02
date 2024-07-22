package controller.notice;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.CommentDAO;
import dao.ItemDAO;
import dao.NoticeDAO;
import dto.Comment;
import dto.Item;
import dto.Notice;


@WebServlet("/notice/noticeview")
public class NoticeView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		String pageNum = request.getParameter("pageNum");
		
		NoticeDAO dao = new NoticeDAO();
		CommentDAO dao2 = new CommentDAO();
		
		Notice n = dao.oneNotice(uid);
		
		ArrayList<Comment> m = dao2.getAllComment(uid);
			
		
		request.setAttribute("n", n);
		request.setAttribute("m", m);	
		
		RequestDispatcher dis = request.getRequestDispatcher("/notice/noticeView.jsp");
		dis.forward(request, response);
	}
}
