package com.board.common;

import lombok.Data;

@Data
public class Pagination {
	private int listSize = 10;  //초기값으로 목록개수를 10으로 셋팅
	private int rangeSize = 10;  //초기값으로 페이지범위를 10으로 셋팅(페이지네이션 몇개 나오는지)
	private int page;	// 현재 페이지 번호
	private int range;	// 현재 페이지 범위 (각 페이지 범위 블럭 수)
	private int totalCount;	// 총 게시물의 개수
	private int totalPage;	// 총 페이지 개수
	private int startPage;	// 각 페이지 범위 시작 번호
	private int endPage;	// 각 페이지 범위 끝 번호
	private int startList;	//
	private int endList;
	private boolean prev;
	private boolean next;

	public void pageInfo(int page, int range, int totalCount) {// page : 현재 페이지, range : 현재 페이지 범위, totalCount : 게시물의 총 개수 

		this.page = page;
		this.range = range;
		this.totalCount = totalCount;

		//전체 페이지수 
		this.totalPage = (int) Math.ceil((double)totalCount/listSize);

		//시작 페이지
		this.startPage = (range - 1) * rangeSize + 1 ;

		//끝 페이지
		this.endPage = range * rangeSize;

		//게시판 시작번호
		this.startList = (page - 1) * listSize;

		//이전 버튼 상태
		this.prev = range == 1 ? false : true;

		//다음 버튼 상태
		this.next = endPage > totalPage ? false : true;

		if (this.endPage >= this.totalPage) {
			this.endPage = this.totalPage;
			this.next = false;
		}

	}
}
