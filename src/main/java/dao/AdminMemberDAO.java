package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Member;

public class AdminMemberDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();

    //총 회원 수
    public int getAllcount(String field,String search) {
        d.getCon();

        int count = 0;
        try {
            String sql = "select count(*) from member";

            if(search != null && !search.equals("")) {
                sql = "select count(*) from member where "+field+" like '%"+search+"%'";
            }

            pstmt=d.con.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //회원목록
    public ArrayList<Member> getAllMember(int startRow,int endRow,String field, String search) {
        d.getCon();

        ArrayList<Member> v = new ArrayList<>();

        try {
            String sql = "select * from member order by signdate desc limit ?,?";
            if(search != null && !search.equals("")) {
                sql = "select * from member where "+field+" like '%"+search+"%' order by signdate desc limit ?,?";
            }   
            pstmt = d.con.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);

            rs = pstmt.executeQuery();

            while(rs.next()) {
                Member m = new Member();

                m.setId(rs.getString("id"));
                m.setName(rs.getString("name"));
                m.setGender(rs.getString("gender"));
                m.setEmail(rs.getString("email"));
                m.setLevel(rs.getString("level"));
                m.setStatus(rs.getString("status"));
                m.setConnecttype(rs.getString("connecttype"));

                v.add(m);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }

    //회원정보
    public Member oneMember(String id) {
        d.getCon();
        Member m = new Member();
        try {
            String sql = "select * from member where id=?";
            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, id);

            rs=pstmt.executeQuery();

            if(rs.next()) {
                m.setId(rs.getString("id"));
                m.setPass(rs.getString("pass"));
                m.setName(rs.getString("name"));
                m.setBirth(rs.getString("birth"));
                m.setPn(rs.getString("pn"));
                m.setEmail(rs.getString("email"));
                m.setZc(rs.getString("zc"));
                m.setZc1(rs.getString("zc1"));
                m.setZc2(rs.getString("zc2"));
                m.setZc3(rs.getString("zc3"));
                m.setZc4(rs.getString("zc4"));
                m.setSigndate(rs.getString("signdate"));
                m.setConnecttype(rs.getString("connecttype"));
                m.setLevel(rs.getString("level"));
                m.setStatus(rs.getString("status"));
                m.setGender(rs.getString("gender"));
            }

            rs.close();
            pstmt.close();
            d.con.close();
        } catch(Exception e){
            e.printStackTrace();
        }
        return m;
    }

    //회원수정
    public void updateMember(Member m) {
        d.getCon();

        try {
            String str="";
            if(m.getPass() != null && !m.getPass().equals("")) {
                str=",pass='"+m.getPass()+"'";
            }

            String sql = "update member set name=?,birth=?,pn=?,email=?,zc=?,zc1=?,zc2=?,zc3=?,zc4=?,level=?,status=?,gender=?"+str+" where id=?";

            pstmt=d.con.prepareStatement(sql);

            pstmt.setString(1,m.getName());
            pstmt.setString(2,m.getBirth());
            pstmt.setString(3,m.getPn());
            pstmt.setString(4,m.getEmail());
            pstmt.setString(5,m.getZc());
            pstmt.setString(6,m.getZc1());
            pstmt.setString(7,m.getZc2());
            pstmt.setString(8,m.getZc3());
            pstmt.setString(9,m.getZc4());
            pstmt.setString(10,m.getLevel());
            pstmt.setString(11,m.getStatus());
            pstmt.setString(12,m.getGender());
            pstmt.setString(13,m.getId());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
