package com.with;

import lombok.Data;

@Data
public class Pagination {
    private int listSize = 9; //초기값으로 목록개수를 10으로 셋팅

    private int rangeSize = 10; //초기값으로 페이지범위를 10으로 셋팅

    private int page;

    private int range;

    private int listCnt;

    private int pageCnt;

    private int startPage;

    private int startList;

    private int endPage;

    private boolean prev;

    private boolean next;
    
    private String keyword;
    
    private int cate;
    
    private String order;
    
    private int user_no;

    public void pageInfo(int page, int range, int listCnt) {//page는 현재 페이지 정보, range는 현재 페이지 범위정보, ListCnt는 게시물의  개수
        this.page = page;
        this.range = range;
        this.listCnt = listCnt;

        this.pageCnt =(int)Math.ceil((double)listCnt/listSize); //전체 페이지 수
        System.out.println(this.pageCnt);
        this.startPage =(range -1)*rangeSize+1; //시작 페이지
        System.out.println(this.startPage);
        this.endPage = range*rangeSize;
        System.out.println(this.endPage);
        this.startList = (page-1)*listSize;
        this.listSize = page*listSize;
        this.prev = range ==1?false:true;

        this.next = endPage>pageCnt?false:true;
        if(this.endPage>this.pageCnt){
            this.endPage = this.pageCnt;
            this.next=false;
        }

    }
    
    public String getKeyword() {
		if(this.keyword == null) {
			this.keyword = "";
		}
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
