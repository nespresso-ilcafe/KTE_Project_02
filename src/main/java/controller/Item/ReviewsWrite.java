package controller.Item;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import dao.ItemDAO;
import dao.ReviewsDAO;
import dto.Reviews;


@WebServlet("/item/reviewsWrite")
public class ReviewsWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ReviewsWrite() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dis = request.getRequestDispatcher("reviewsWrite.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Date date = new Date();
		SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String rv_date = sim.format(date);
		
		//이미지 처리
		String uploadPath="/Users/kwanwoobyun/eclipse/project02/src/main/webapp/upload_item";
		int size=10*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
		Reviews rv = new Reviews();
		
		rv.setMb_id(multi.getParameter("mb_id"));
		rv.setRv_date(rv_date);
		rv.setIt_uid(Integer.parseInt(multi.getParameter("it_uid")));
		rv.setRating(Integer.parseInt(multi.getParameter("rating")));
		rv.setRv_sub(multi.getParameter("rv_sub"));
		rv.setRv_text(multi.getParameter("rv_text"));
		
		Enumeration files=multi.getFileNames(); 

	    String file3 = (String)files.nextElement();
	    String file3_rename = multi.getFilesystemName(file3);
	    if(file3_rename == null) { file3_rename = ""; }

		String file2 = (String)files.nextElement();
		String file2_rename = multi.getFilesystemName(file2);
		if(file2_rename == null) { file2_rename = ""; }
		
		String file1 = (String)files.nextElement();
		String file1_rename = multi.getFilesystemName(file1);
		if(file1_rename == null) { file1_rename = ""; }
		
		rv.setFile1(file1_rename);
		rv.setFile2(file2_rename);
		rv.setFile3(file3_rename);
		  
		String file1_thumb = ""; // 썸네일 파일명 미구현
  
		//// 썸네일 시작 ////
		if(!file1_rename.equals("")){ // 첨부파일1 있다면
		String oPath = uploadPath+"/"+file1_rename; // 첨부파일1 원본 경로
		File oFile = new File(oPath);
		
		int index = oPath.lastIndexOf(".");
		String ext = oPath.substring(index + 1); // 파일 확장자
		
		file1_thumb = "thumb_" + oFile.getName(); //썸네일 파일명
		
		String tPath = oFile.getParent() + File.separator + file1_thumb; // 썸네일 저장 경로 및 파일명
		File tFile = new File(tPath);
		
		double ratio = 2; // 이미지 축소 비율(용량 줄이기)
		
		try {
			BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
			int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
			int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
			
			BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
			Graphics2D graphic = tImage.createGraphics();
			Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
			graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
			graphic.dispose(); // 리소스를 모두 해제
			
			ImageIO.write(tImage, ext, tFile); //썸네일 저장
		    } catch (IOException e) {
		       e.printStackTrace();
		    }
		}
		 
		rv.setFile1_thumb(file1_thumb); //썸네일 명 
		 //// 썸네일 끝 //// 
		
		ReviewsDAO dao = new ReviewsDAO();
		
		dao.insertReviews(rv);
		String or_uid = request.getParameter("or_uid");
		System.out.println(or_uid);
		dao.afterReview(or_uid);
		
		String mb_id = request.getParameter("mb_id");
		String od_id = request.getParameter("od_id");
		response.sendRedirect("/orders/userorderview?mb_id="+mb_id+"&od_id="+od_id);
	}
}
