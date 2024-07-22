package controller.Item;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import dto.Item;
import dto.ItemQna;


@WebServlet("/item/iqDelete")
public class IqDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public IqDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		ItemDAO dao = new ItemDAO();
		String category2 = request.getParameter("category2");
		String it_uid = request.getParameter("it_uid");
		String thread = request.getParameter("thread");
		int qna_uid = Integer.parseInt(request.getParameter("qna_uid"));
		int fid = Integer.parseInt(request.getParameter("fid"));
		int fidLength = dao.getFidLength(it_uid,fid);
		
		PrintWriter out = response.getWriter();
		if(fidLength == 1) {
			dao.qnaDelete(qna_uid);
			out.print("<script>");
			out.print("alert('삭제완료!');");
			out.print("location.href='/item/view?it_uid="+it_uid+"&category2="+category2+"';");
			out.print("</script>");
		}else {
			out.print("<script>");
			out.print("alert('답글이 존재하는 글은 삭제하실 수 없습니다!');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
