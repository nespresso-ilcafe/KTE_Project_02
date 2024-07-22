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

import dao.CategoryDAO;
import dao.ItemDAO;
import dto.Category;
import dto.ItemQna;


@WebServlet("/item/iqAnswer")
public class IqAnswer extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IqAnswer() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ItemDAO dao = new ItemDAO();
		
		int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		
		ItemQna iq = dao.oneItemQna(qna_uid, it_uid);
		request.setAttribute("iq", iq);
		
		RequestDispatcher dis = request.getRequestDispatcher("iqAnswer.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    ItemQna iq = new ItemQna();
	    ItemDAO dao = new ItemDAO();
	    HttpSession session = request.getSession();
	    
		String it_uid = request.getParameter("it_uid");
	    String mb_id = (String) session.getAttribute("id");
	    int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
	    String category2 = request.getParameter("category2");
	    
	    Date date = new Date();
	    SimpleDateFormat sim = new SimpleDateFormat("yyyy.MM.dd");
	    String signdate = sim.format(date);
	    
	    //thread 가져오기
	    int fid = Integer.parseInt(request.getParameter("fid"));
	    String thread = "A";
	    String newThread = dao.getThread(fid, thread);
	    
	    iq.setMb_id(mb_id);
	    iq.setIt_uid(Integer.parseInt(it_uid));
	    iq.setQna_subject(request.getParameter("qna_subject"));
	    iq.setComment(request.getParameter("comment"));
	    iq.setSigndate(signdate);
	    iq.setType1(request.getParameter("type1"));
	    iq.setFid(fid);
	    iq.setThread(newThread);

	    dao.insertItemQna(iq);
	    
	    String backUrl = "/item/view?it_uid=" + it_uid + "&category2="+ category2 +"&qna_uid=" + qna_uid;
	    response.sendRedirect(backUrl);
	}
}
