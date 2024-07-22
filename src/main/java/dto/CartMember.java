package dto;

import lombok.Data;

@Data
public class CartMember {
	private String ct_uid;
	private String od_id;
	private String mb_id;
	private String it_uid;
	private String it_opt1;
	private String it_price;
	private String it_sale; //세일가격
	private String it_point;
	private String it_qty;
	private String ct_status;
	private String ct_date;
	private String file1_thumb; // item 테이블 file1 
	private String id;
	private String pass;
	private String name;
	private String birth;
	private String pn;
	private String email;
	private String zc;
	private String zc1;
	private String zc2;
	private String zc3;
	private String zc4;
	private String signdate;
	private String connecttype;
	private String level;
	private String status;
	private String gender;
	private String point;
}
