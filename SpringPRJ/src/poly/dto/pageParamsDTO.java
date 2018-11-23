package poly.dto;

public class pageParamsDTO {
	private int currentPage;
	private int rowCount;
	private String sortValue;
	private String arrangeOrder;
	private int totalCount;
	private int totalPages;
	private String searchContent;
	
	public String getSearchContent() {
		return searchContent;
	}
	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPages() {
		return totalPages;
	}
	public void setTotalPages(int totalPage) {
		this.totalPages = totalPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public String getSortValue() {
		return sortValue;
	}
	public void setSortValue(String sortValue) {
		this.sortValue = sortValue;
	}
	public String getArrangeOrder() {
		return arrangeOrder;
	}
	public void setArrangeOrder(String arrangeOrder) {
		this.arrangeOrder = arrangeOrder;
	}
	
	
}