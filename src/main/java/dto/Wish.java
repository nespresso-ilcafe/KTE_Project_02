package dto;

import lombok.Data;

@Data
public class Wish {
	private int uid;
	private String user_id;
    private int it_uid;
    private String it_name;
    private int it_price;
    private String sale_status;
    private int qty;//구매수량
    private String it_option;
    private int it_point;
    private int it_sale;
    private String file1_thumb; // item 테이블 file1 
    private int it_qty1; //판매 상품 총 갯수
}