package admin.banner;

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

import dao.BannerDAO;
import dao.ItemDAO;
import dto.Banner;
import dto.Category;
import dto.Item;

@WebServlet("/admin/banner/bannermodify")
public class BannerModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public BannerModify() {
        super();
 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		BannerDAO dao = new BannerDAO();
		
		Banner b = dao.oneBanner(uid);
		
		ArrayList<Banner> v = dao.getAllBanner(0,100);
		
		request.setAttribute("v", v);
		request.setAttribute("b", b);
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/banner/bannermodify.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uploadPath="/Users/kwanwoobyun/eclipse-workspace/project02/src/main/webapp/upload_item";
		int size=10*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
	
		Banner b = new Banner();
	    
		b.setUid(Integer.parseInt(multi.getParameter("uid")));
        b.setSubject(multi.getParameter("subject"));
        b.setUrl(multi.getParameter("url"));
		
		Enumeration files=multi.getFileNames();

		String file1 = (String)files.nextElement();
		String file1_rename = multi.getFilesystemName(file1);
		if(file1_rename == null) { file1_rename = ""; }
		
		b.setFile1(file1_rename);
		
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
			//// 썸네일 끝 //// 
			
			b.setFile1_thumb(file1_thumb); //썸네일 명
	    
	    BannerDAO dao = new BannerDAO();
	    dao.updateBanner(b);

	    response.sendRedirect("/admin/banner/bannerlist");
	}
}
