package controller.Item;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ItemDAO;
import dto.Category;
import dto.Item;
import dto.ItemQna;


@WebServlet("/item/iqQuestion")
public class iqQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public iqQuestion() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/item/iqQuestion.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("utf-8");
	    HttpSession session = request.getSession();
	    
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
	    String mb_id = (String) session.getAttribute("id");
	    String category2 = request.getParameter("category2");
	    
	    Date date = new Date();
	    SimpleDateFormat sim = new SimpleDateFormat("yyyy.MM.dd");
	    String signdate = sim.format(date);

	    ItemQna iq = new ItemQna();
	    ItemDAO dao = new ItemDAO();
	    
	    //fid 가져오기
	    int newFid = dao.getFid(it_uid);
	    
	    //thread 가져오기
	    String thread = "A";
	    
	    iq.setMb_id(mb_id);
	    iq.setIt_uid(it_uid);
	    iq.setQna_subject(request.getParameter("qna_subject"));
	    iq.setComment(request.getParameter("comment"));
	    iq.setSigndate(signdate);
	    iq.setType1(request.getParameter("type1"));
	    iq.setFid(newFid);
	    iq.setThread(thread);
	    
	    dao.insertItemQna(iq);
	    
	    String backUrl = "/item/view?it_uid=" + it_uid + "&category2=" + category2;
	    response.sendRedirect(backUrl);
	}
}
