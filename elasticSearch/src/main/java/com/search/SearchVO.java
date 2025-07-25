package com.search;

public class SearchVO{

    public static final String ORDER_ASC = "ASC";
    public static final String ORDER_DESC = "DESC";
    
    /**
     * 순번
     */
    private int rowNum;

    /**
     * 통합검색 검색
     */
    private String searchTotalKeyWord;
    
    /*------------------------ 구축관리(통합검색) ------------------------*/
    /**
     * 구축상태 검색 -- 구축자/검수자 페이지
     */
    private String workTypeUser;

    /**
     * 통합검색 -- 구축조건 선택(구축, 검수)
     */
    private String dataReg;

    /**
     * 통합검색 -- 조건(구축) 
     */
    private String[] dataRegCheck;

    /**
     * 통합검색 -- 조건(검수)
     */
    private String[] ruleCheck;

    /**
     * 통합검색 -- 작업자선택 검색키워드
     */
    private String regWorkerSearchWord;
    
    /**
     * 통합검색 -- 작업자선택 검색키워드 sort
     */
    private String regWorkerSortSearchWord;
    
    /**
     * 통합검색 -- 배분일자(From) 
     */
    private String divDateFrom;

    /**
     * 통합검색 -- 배분일자(To)
     */
    private String divDateTo;

    /**
     * 통합검색 -- 구축일자(From)
     */
    private String finDateFrom;

    /**
     * 통합검색 -- 구축일자(To)
     */
    private String finDateTo;

    
    /*------------------------ 구축관리(통합검색) ------------------------*/

    
    /**
     * 검색어(sort 형)
     */
    private String regSortKeyword;

	/**
	 * 검색어
	 */
	private String regSearchKeyWord;

	/**
	 * 검색필드
	 */
	private String regSearchOption;
	
	/**
	 * 정렬기준
	 */
	private String regOrderCategory;
	
	/**
	 * 정렬방식
	 */
	private String regOrderType;
    
    
    
    
    
    
    /**
     * 배분일자
     */
    private String divDate;
    
    /**
     * 완료일자
     */
    private String finDate;
    
    
    /**
     * 엑셀 반출타입
     */
    private String exportType;

	/**
     * 
     */
    private String searchTarget;
    
    /**
     * 
     */
    private String searchString;
    
    /**
     * 
     */
    private String searchType;
    
    /**
     * 
     */
    private String searchWord;
    
    /**
     * 
     */
    private String filterType;
    
    /**
     * 
     */
    private String listOrder;
    
    /**
     * 
     */
    private String orderDir = SearchVO.ORDER_DESC;
    
    /**
     * 
     */
    private String date;   // 일자
    
    /**
     * 
     */
    private String fileNm; // 파일명
    
    /**
     * 로그인ID
     */
    private String admnId;
    
    /**
     * 권한
     */
    private String operAuth;

    /**
     * 배열목록
     */
    private String[] items;

    /* 페이징관련 맴버변수 */
    /**
     * 
     */
    private String itemsPerPage = "10";
    
    /**
     * 
     */
    private String pageNum = "1";
    
    /**
     * 
     */
    private int totalCount = 0;
    
    /**
     * 
     */
    private int totalArtCount = 0;
    
    /**
     * 
     */
    private int totalVolCount = 0;
    
    /**
     * 
     */

    /**
     * 검색창 Open 체크
     */
    private String openChk;
    
    /**
     * 메인에서 넘어온 여부 판단
     */
    private String mainChk;
    
    
    /** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색사용여부 */
    private String searchUseYn = "";
    
    /** 현재페이지 */
    private int pageIndex = 1;
    
    /** 페이지갯수 */
    private int pageUnit = 10;
    
    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    private String subPage = "00";
    
    private String searchCmYyyy = "";
    public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSubPage() {
		return subPage;
	}

	public void setSubPage(String subPage) {
		this.subPage = subPage;
	}

	public String getSearchCmYyyy() {
		return searchCmYyyy;
	}

	public void setSearchCmYyyy(String searchCmYyyy) {
		this.searchCmYyyy = searchCmYyyy;
	}

	public String getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}

	public String getSearchLoginId() {
		return searchLoginId;
	}

	public void setSearchLoginId(String searchLoginId) {
		this.searchLoginId = searchLoginId;
	}

	private String searchStatus = "";
    
    private String searchLoginId = "";
    
	public String getWorkTypeUser() {
		return workTypeUser;
	}

	public void setWorkTypeUser(String workTypeUser) {
		this.workTypeUser = workTypeUser;
	}


	public String getDataReg() {
		return dataReg;
	}

	public void setDataReg(String dataReg) {
		this.dataReg = dataReg;
	}

	public String[] getDataRegCheck() {
		return dataRegCheck;
	}

	public void setDataRegCheck(String[] dataRegCheck) {
		this.dataRegCheck = dataRegCheck;
	}

	
	
	public String[] getRuleCheck() {
		return ruleCheck;
	}

	public void setRuleCheck(String[] ruleCheck) {
		this.ruleCheck = ruleCheck;
	}

	public String getRegWorkerSearchWord() {
		return regWorkerSearchWord;
	}

	public void setRegWorkerSearchWord(String regWorkerSearchWord) {
		this.regWorkerSearchWord = regWorkerSearchWord;
	}

	public String getRegWorkerSortSearchWord() {
		return regWorkerSortSearchWord;
	}

	public void setRegWorkerSortSearchWord(String regWorkerSortSearchWord) {
		this.regWorkerSortSearchWord = regWorkerSortSearchWord;
	}

	public String getDivDateFrom() {
		return divDateFrom;
	}

	public void setDivDateFrom(String divDateFrom) {
		this.divDateFrom = divDateFrom;
	}

	public String getDivDateTo() {
		return divDateTo;
	}

	public void setDivDateTo(String divDateTo) {
		this.divDateTo = divDateTo;
	}

	public String getFinDateFrom() {
		return finDateFrom;
	}

	public void setFinDateFrom(String finDateFrom) {
		this.finDateFrom = finDateFrom;
	}

	public String getFinDateTo() {
		return finDateTo;
	}

	public void setFinDateTo(String finDateTo) {
		this.finDateTo = finDateTo;
	}

	public String getDivDate() {
		return divDate;
	}

	public void setDivDate(String divDate) {
		this.divDate = divDate;
	}

	public String getFinDate() {
		return finDate;
	}

	public void setFinDate(String finDate) {
		this.finDate = finDate;
	}

	public String getSearchWord() {
        return searchWord;
    }
    
    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }
    
    public String getSearchTarget() {
        return searchTarget;
    }
    
    public void setSearchTarget(String searchTarget) {
        this.searchTarget = searchTarget;
    }
    
    public String getSearchString() {
        return searchString;
    }
    
    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }
    
    public String getFilterType() {
        return filterType;
    }
    
    public void setFilterType(String filterType) {
        this.filterType = filterType;
    }
    
    public String getListOrder() {
        return listOrder;
    }
    
    public void setListOrder(String listOrder) {
        this.listOrder = listOrder;
    }
    
    public int getTotalCount() {
        return totalCount;
    }

    public int getTotalArtCount() {
		return totalArtCount;
	}

	public void setTotalArtCount(int totalArtCount) {
		this.totalArtCount = totalArtCount;
	}
	
	public int getTotalVolCount() {
		return totalVolCount;
	}

	public void setTotalVolCount(int totalVolCount) {
		this.totalVolCount = totalVolCount;
	}
    
    public void setItemsPerPage(String itemsPerPage) {
        this.itemsPerPage = itemsPerPage;
    }
    
    public void setPageNum(String pageNum) {
        this.pageNum = pageNum;
    }

    public String getOrderDir() {
        return orderDir;
    }

    public void setOrderDir(String orderDir) {
        this.orderDir = orderDir;
    }

    public String getItemsPerPage() {
        return this.itemsPerPage;
    }

    public String getPageNum() {
        return this.pageNum;
    }

    public String getPagesPerNav() {
        return "5";
    }
    
    public static String getOrderAsc() {
        return ORDER_ASC;
    }
    
    public static String getOrderDesc() {
        return ORDER_DESC;
    }
    
    public String getSearchType() {
        return searchType;
    }
    
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    
    public String getAdmnId() {
        return admnId;
    }
    
    public void setAdmnId(String admnId) {
        this.admnId = admnId;
    }
    
    public String getOperAuth() {
        return operAuth;
    }
    
    public void setOperAuth(String operAuth) {
        this.operAuth = operAuth;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getFileNm() {
        return fileNm;
    }

    public void setFileNm(String fileNm) {
        this.fileNm = fileNm;
    }

    public String[] getItems() {
        return items;
    }
    
    public void setItems(String[] items) {
        this.items = items;
    }
    
	public String getRegSearchKeyWord() {
		return regSearchKeyWord;
	}
	
	public void setRegSearchKeyWord(String regSearchKeyWord) {
		this.regSearchKeyWord = regSearchKeyWord;
	}
	
	public String getRegSearchOption() {
		return regSearchOption;
	}
	
	public void setRegSearchOption(String regSearchOption) {
		this.regSearchOption = regSearchOption;
	}
	
	public String getRegOrderCategory() {
		return regOrderCategory;
	}
	
	public void setRegOrderCategory(String regOrderCategory) {
		this.regOrderCategory = regOrderCategory;
	}
	
	public String getRegOrderType() {
		return regOrderType;
	}
	
	public void setRegOrderType(String regOrderType) {
		this.regOrderType = regOrderType;
	}
	
	public String getRegSortKeyword() {
		return regSortKeyword;
	}

	public void setRegSortKeyword(String regSortKeyword) {
		this.regSortKeyword = regSortKeyword;
	}
	
    public String getExportType() {
		return exportType;
	}

	public void setExportType(String exportType) {
		this.exportType = exportType;
	}

	public String getOpenChk() {
		return openChk;
	}

	public void setOpenChk(String openChk) {
		this.openChk = openChk;
	}

	public String getMainChk() {
		return mainChk;
	}

	public void setMainChk(String mainChk) {
		this.mainChk = mainChk;
	}

	public String getSearchTotalKeyWord() {
		return searchTotalKeyWord;
	}

	public void setSearchTotalKeyWord(String searchTotalKeyWord) {
		this.searchTotalKeyWord = searchTotalKeyWord;
	}

	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	
	
	
	
	
}
