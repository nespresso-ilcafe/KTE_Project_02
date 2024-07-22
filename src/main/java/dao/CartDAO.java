package dao;

import java.lang.reflect.Array;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


import dto.Cart;
import dto.CartMember;
import dto.Category;
import dto.Item;
import dto.Orders;

public class CartDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();

    //상품 추가
    public void insertCart(Cart c) {
        d.getCon();

        try {
            String sql = "insert into cart values (null,?,?,?,?,?,?,?,?,?)";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, c.getMb_id());
            pstmt.setInt(2, c.getIt_uid());
            pstmt.setInt(3, c.getIt_price());
            pstmt.setInt(4, c.getIt_point());
            pstmt.setInt(5, c.getIt_qty());
            pstmt.setString(6, "준비");
            pstmt.setString(7, c.getCt_date());
            pstmt.setString(8, c.getIt_opt1());
            pstmt.setInt(9, c.getIt_sale());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //전체 상품 수
    public int getAllcount(String id) {
        d.getCon();

        int count = 0;

        try {
            String sql = "select count(*) from cart where mb_id=? and ct_status='준비'";

            pstmt=d.con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            d.con.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //목록 배열 
    public ArrayList<Cart> getAllMember(String id) {
        d.getCon();

        ArrayList<Cart> v = new ArrayList<Cart>();

        try {
            String sql = "select c.*, i.* from cart c inner join item i on c.it_uid = i.it_uid where c.mb_id=? and c.ct_status='준비' ORDER BY c.ct_uid DESC";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, id);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Cart c = new Cart();


                String ct_date = rs.getString("ct_date").substring(0, 10); // 등록 년월일

                c.setCt_uid(rs.getInt("c.ct_uid"));
                c.setMb_id(rs.getString("c.mb_id"));
                c.setIt_uid(rs.getInt("c.it_uid"));
                c.setIt_price(rs.getInt("c.it_price"));
                c.setIt_point(rs.getInt("c.it_point"));
                c.setIt_qty(rs.getInt("c.it_qty"));
                c.setCt_status(rs.getString("c.ct_status"));
                c.setCt_date(ct_date);
                c.setIt_opt1(rs.getString("c.it_opt1"));
                c.setIt_sale(rs.getInt("c.it_sale"));

                Item i = new Item();
                i.setIt_qty(rs.getInt("i.it_qty"));
                i.setFile1_thumb(rs.getString("i.file1_thumb"));

                c.setItem(i);
                v.add(c);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return v;
    }

    // 상품 삭제
    public void oneDelete(String ct_uid) {
        d.getCon();

        try {
            String sql = "DELETE FROM cart WHERE ct_uid = ?";
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, ct_uid);

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //상품 존재여부
    public int selectItem(Cart c) {
        d.getCon();
        int num = 0;
        try {
            String sql = "select count(*) from cart where mb_id=? and it_uid=? and it_opt1=?and ct_status='준비'";
            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, c.getMb_id());
            pstmt.setInt(2, c.getIt_uid());
            pstmt.setString(3, c.getIt_opt1());

            // executeQuery() 메서드를 호출한 후에 결과 집합을 rs 변수에 할당
            rs = pstmt.executeQuery();

            if(rs.next()) {
                num = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }

    public void oneUpdate(Cart c) {
        d.getCon();

        try {
            String sql = "UPDATE cart SET it_qty = it_qty + ? WHERE mb_id=? AND it_uid=? and it_opt1=?";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setInt(1, c.getIt_qty());
            pstmt.setString(2, c.getMb_id());
            pstmt.setInt(3, c.getIt_uid());
            pstmt.setString(4, c.getIt_opt1());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void ptyUpdate(int ct_uid,String str) {
        d.getCon();

        try {
            String sql = "update cart set it_qty -1 where ct_uid=?";
            if(str.equals("p")) {
                sql = "update cart set it_qty +1 where ct_uid=?";
            }

            pstmt = d.con.prepareStatement(sql);
            pstmt.setInt(1, ct_uid);

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //체크아웃 페이지로 불러오기
    public ArrayList<CartMember> forOrderList(String mb_id, String[] ct_uids){
        d.getCon();

        ArrayList<CartMember> cmArr = new ArrayList<CartMember>();

        try {
            String sql = "Select *, (SELECT file1_thumb FROM item WHERE item.it_uid=cart.it_uid) AS file1_thumb from cart right join member on cart.mb_id = member.id where cart.mb_id=? and ct_uid in(";

            for(int i = 0; i < ct_uids.length; i++) {
                sql += "?"; // Placeholder 추가
                if (i != ct_uids.length - 1) {
                    sql += ", "; // 마지막 요소가 아닌 경우 쉼표 추가
                }
            }
            sql += ")"; // IN 연산자 종료

            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, mb_id);
            for (int i = 0; i < ct_uids.length; i++) {
                pstmt.setString(i + 2, ct_uids[i]); // i + 2는 첫 번째 매개변수 이후부터
            }
            rs = pstmt.executeQuery();

            while(rs.next()) {
                CartMember cm = new CartMember();

                cm.setCt_uid(rs.getString("ct_uid"));
                cm.setMb_id(rs.getString("mb_id"));
                cm.setIt_uid(rs.getString("it_uid"));
                cm.setIt_price(rs.getString("it_price"));
                cm.setIt_point(rs.getString("it_point"));
                cm.setIt_qty(rs.getString("it_qty"));
                cm.setCt_status(rs.getString("ct_status"));
                cm.setCt_date(rs.getString("ct_date"));
                cm.setIt_opt1(rs.getString("it_opt1"));
                cm.setIt_sale(rs.getString("it_sale"));
                cm.setFile1_thumb(rs.getString("file1_thumb"));

                cm.setId(rs.getString("id"));
                cm.setPass(rs.getString("pass"));
                cm.setName(rs.getString("name"));
                cm.setBirth(rs.getString("birth"));
                cm.setPn(rs.getString("pn"));
                cm.setEmail(rs.getString("email"));
                cm.setZc(rs.getString("zc"));
                cm.setZc1(rs.getString("zc1"));
                cm.setZc2(rs.getString("zc2"));
                cm.setZc3(rs.getString("zc3"));
                cm.setZc4(rs.getString("zc4"));
                cm.setPoint(rs.getString("point"));

                cmArr.add(cm);

            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmArr;
    }

    //오다 인서트
    public void insertOrders(ArrayList<Orders> orArr, int count){
        d.getCon();
        try {
            String sql = "insert into orders values (null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            pstmt = d.con.prepareStatement(sql);

            for(int i = 0; i<count; i ++ ) {
                Orders or = orArr.get(i);

                if(or.getMb_id() == null) {
                    break;
                }else {
                    pstmt.setString(1, or.getMb_id());
                    pstmt.setString(2, or.getIt_uid());
                    pstmt.setString(3, or.getIt_price());
                    pstmt.setString(4, or.getIt_point());
                    pstmt.setString(5, or.getIt_qty());
                    pstmt.setString(6, "주문");
                    pstmt.setString(7, or.getIt_opt1());
                    pstmt.setString(8, or.getZc());
                    pstmt.setString(9, or.getZc1());
                    pstmt.setString(10, or.getZc2());
                    pstmt.setString(11, or.getZc3());
                    pstmt.setString(12, or.getZc4());
                    pstmt.setString(13, or.getOr_opt());
                    pstmt.setString(14, or.getPn());
                    pstmt.setString(15, or.getOr_date());
                    pstmt.setString(16, or.getName());
                    pstmt.setString(17, or.getOd_id());
                }
                pstmt.executeUpdate();
            }

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //status변경
    public void statusChange(String[] ct_uid, int count) {
        d.getCon();
        try {
            String sql = "update cart set ct_status='주문' where ct_uid=?";
            pstmt = d.con.prepareStatement(sql);
            for(int i = 0; i<count; i ++ ) {
                pstmt.setString(1, ct_uid[i]);
                pstmt.executeUpdate();
            }

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //적립금 지급
    public void setPoint(String mb_id, int totalPoints) {
    	d.getCon();
    	try {
    		String sql = "update member set point = ? where id = ?";
    		pstmt = d.con.prepareStatement(sql);
    		pstmt.setInt(1, totalPoints);
    		pstmt.setString(2, mb_id);
    		pstmt.executeUpdate();
    		
    		pstmt.close();
    		d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    //qty변경
    public void qtyUpdate(String[] ct_uid, int count) {
        d.getCon();
        try {
            String sql = "UPDATE item SET it_qty = it_qty - (SELECT it_qty FROM cart WHERE ct_uid = ?) WHERE it_uid = (SELECT it_uid FROM cart WHERE ct_uid = ?)";
            pstmt = d.con.prepareStatement(sql);
            for(int i = 0; i<count; i ++ ) {
                pstmt.setString(1, ct_uid[i]);
                pstmt.setString(2, ct_uid[i]);
                pstmt.executeUpdate();
            }

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    //장바구니 같은 상품 수량의 합
    public int getAllqty(String id, int it_uid) {
        d.getCon();

        int count = 0;

        try {
            String sql = "select sum(it_qty) from cart where mb_id=? and it_uid=? and ct_status='준비'";

            pstmt=d.con.prepareStatement(sql);

            pstmt.setString(1, id);
            pstmt.setInt(2, it_uid);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            d.con.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    //삭제
    public void oneDelete(int ct_uid) {
        d.getCon();

        try {
            String sql = "delete from cart where ct_uid=?";

            pstmt=d.con.prepareStatement(sql);

            pstmt.setInt(1, ct_uid);

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

}
