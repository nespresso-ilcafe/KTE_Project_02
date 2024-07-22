package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Banner;
import dto.Item;

public class BannerDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();

    //총 배너 수
    public int getAllcount() {
        d.getCon();

        int count = 0;
        try {
            String sql = "select count(*) from banner";

            pstmt = d.con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //배너 목록 
    public ArrayList<Banner> getAllBanner(int startRow, int endRow) {
        d.getCon();

        ArrayList<Banner> v = new ArrayList<Banner>();

        try {
            String sql = "select * from banner order by uid desc limit ?,?";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Banner b = new Banner();

                b.setUid(rs.getInt("uid"));
                b.setSubject(rs.getString("subject"));
                b.setFile1(rs.getString("file1"));
                b.setFile1_thumb(rs.getString("File1_thumb"));
                b.setUrl(rs.getString("url"));

                v.add(b);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return v;
    }

    //배너등록 
    public void insertBanner(Banner b) {
        d.getCon();

        try {
            String sql = "insert into banner values (null,?,?,?,?)";
            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, b.getSubject());            
            pstmt.setString(2, b.getFile1());
            pstmt.setString(3, b.getFile1_thumb()); //썸네일
            pstmt.setString(4, b.getUrl());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //삭제
    public void oneDelete(int uid) {
        d.getCon();

        try {
            String sql = "delete from banner where uid=?";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setInt(1, uid);

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //배너 상세보기 페이지 
    public Banner oneBanner(int uid) {
        d.getCon();
        Banner b = new Banner();

        try {
            String sql = "select * from banner where uid=?";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setInt(1, uid);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                b.setUid(rs.getInt("uid"));
                b.setSubject(rs.getString("subject"));
                b.setFile1(rs.getString("file1"));
                b.setFile1_thumb(rs.getString("file1_thumb"));
                b.setUrl(rs.getString("url"));
            }

            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }

    //배너수정
    public void updateBanner(Banner b) {
        d.getCon();

        try {
            String str = "";
            if (b.getFile1() != null && !b.getFile1().equals("")) {
                str = ",file1='" + b.getFile1() + "'";
            }
            String str5 = "";
            if (b.getFile1_thumb() != null && !b.getFile1_thumb().equals("")) {
                str5 = ",file1_thumb='" + b.getFile1_thumb() + "'";
            }

            String sql = "update banner set subject=?,url=?" + str + str5 + " where uid=?";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, b.getSubject());
            pstmt.setString(2, b.getUrl());
            pstmt.setInt(3, b.getUid());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
