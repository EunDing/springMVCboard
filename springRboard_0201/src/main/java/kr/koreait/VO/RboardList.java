package kr.koreait.VO;

import java.util.ArrayList;

public class RboardList {
	
	ArrayList<RboardVO> list = new ArrayList<RboardVO>();
			
	private int totalCount;
	private int totalPage;
	private int currentPage;
	private int pageSize;
	private int startNo;
	private int endNo;
	private int startPage;
	private int endPage;
	
	public RboardList() {
	}
	public RboardList(int pageSize, int totalCount, int currentPage) {
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.currentPage = currentPage;
		calculator();
	}

	//나머지 5개의 변수를 계산하는 메소드.
	private void calculator() {
			totalPage = (totalCount - 1) / pageSize + 1;
			currentPage = currentPage > totalPage ? totalPage : currentPage;
			//mysql은 index 번호가 0부터 시작, 오라클은 1부터 시작하므로 startNo 계산할 때 
			//맨 뒤에 1을 더 추가해준다.
			startNo = (currentPage - 1) * pageSize +1;
			endNo = startNo + pageSize - 1;
			endNo = endNo > totalCount ? totalCount : endNo;
			startPage = (currentPage-1)/10 *10 +1; 
			endPage = startPage +9;
			endPage = endPage > totalPage ? totalPage:endPage;
	}

	public ArrayList<RboardVO> getList() {
		return list;
	}

	public void setList(ArrayList<RboardVO> list) {
		this.list = list;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
}
