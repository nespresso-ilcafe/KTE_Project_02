package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dto.Reviews;

public class ReviewsDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();
    
    public void insertReviews(Reviews r) {
    	d.getCon();
    	try {
			String sql = "insert into reviews values (null,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = d.con.prepareStatement(sql);
			pstmt.setString(1, r.getMb_id());
			pstmt.setInt(2, r.getIt_uid());
			pstmt.setDouble(3, r.getRating());
			pstmt.setString(4, r.getRv_text());
			pstmt.setString(5, r.getRv_date());
			pstmt.setString(6, r.getRv_sub());
			pstmt.setString(7, r.getFile1());
			pstmt.setString(8, r.getFile2());
			pstmt.setString(9, r.getFile3());
			pstmt.setString(10, r.getFile1_thumb());

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
	
    //상태변경
    public void afterReview(String or_uid) {
    	d.getCon();
  		try {
			String sql = "update orders set ct_status='리뷰작성' where or_uid=?";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setString(1, or_uid);
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
