package dto;

import lombok.Data;

@Data
public class ItemQna {
    private int qna_uid;
    private String mb_id;
    private int it_uid;
    private String qna_subject;
    private String comment;
    private String signdate;
    private int ref;
    private String type1;
    private int fid;
    private String thread;
}

