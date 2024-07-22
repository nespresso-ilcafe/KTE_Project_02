package dto;

import lombok.Data;

@Data
public class Notice {
	private int uid;
	private String id;
	private String name;
	private String subject;
	private String comment;
	private String signdate;
	private int ref;
	private String gongji;
}
