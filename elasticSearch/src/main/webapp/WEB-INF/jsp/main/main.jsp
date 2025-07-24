<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합검색 테스트</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 검색 영역 */
        .search-header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .search-input {
            flex: 1;
            padding: 12px 16px;
            font-size: 16px;
            border: 2px solid #ddd;
            border-radius: 4px;
            outline: none;
        }

        .search-input:focus {
            border-color: #007bff;
        }

        .search-btn {
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .search-btn:hover {
            background-color: #0056b3;
        }

        .detail-search-btn {
            padding: 12px 20px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .detail-search-btn:hover {
            background-color: #545b62;
        }

        /* 상세검색 팝업 */
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .popup-content {
            background: white;
            padding: 30px;
            border-radius: 8px;
            width: 600px;
            max-width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #007bff;
        }

        .popup-title {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .popup-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #666;
        }

        .popup-close:hover {
            color: #333;
        }

        .search-form-group {
            margin-bottom: 20px;
        }

        .search-form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .search-form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-form-input:focus {
            outline: none;
            border-color: #007bff;
        }

        .search-form-select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background-color: white;
        }

        .search-form-row {
            display: flex;
            gap: 15px;
            align-items: end;
        }

        .search-form-row .search-form-group {
            flex: 1;
        }

        .checkbox-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .checkbox-item input[type="checkbox"] {
            margin: 0;
        }

        .checkbox-item label {
            font-size: 14px;
            color: #555;
            cursor: pointer;
        }

        .radio-group {
            display: flex;
            gap: 20px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .radio-item input[type="radio"] {
            margin: 0;
        }

        .radio-item label {
            font-size: 14px;
            color: #555;
            cursor: pointer;
        }

        .popup-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .popup-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .popup-btn-primary {
            background-color: #007bff;
            color: white;
        }

        .popup-btn-primary:hover {
            background-color: #0056b3;
        }

        .popup-btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .popup-btn-secondary:hover {
            background-color: #545b62;
        }

        .popup-btn-outline {
            background-color: white;
            color: #6c757d;
            border: 1px solid #6c757d;
        }

        .popup-btn-outline:hover {
            background-color: #f8f9fa;
        }

        /* 검색어 영역 */
        .search-terms {
            display: flex;
            gap: 30px;
        }

        .related-search, .popular-search {
            flex: 1;
        }

        .search-section-title {
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
        }

        .search-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .tag {
            background-color: #f8f9fa;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            color: #495057;
            text-decoration: none;
            border: 1px solid #e9ecef;
        }

        .tag:hover {
            background-color: #e9ecef;
            color: #007bff;
        }

        /* 메인 컨텐츠 영역 */
        .main-content {
            display: flex;
            gap: 20px;
        }

        /* 왼쪽 패싯 영역 */
        .facet-area {
            width: 250px;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            height: fit-content;
        }

        .facet-section {
            margin-bottom: 25px;
        }

        .facet-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
            padding-bottom: 5px;
            border-bottom: 2px solid #007bff;
        }

        .facet-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }

        .facet-item input[type="checkbox"] {
            margin-right: 8px;
        }

        .facet-item label {
            font-size: 14px;
            color: #555;
            cursor: pointer;
        }

        .facet-count {
            margin-left: auto;
            font-size: 12px;
            color: #999;
        }

        /* 오른쪽 검색결과 영역 */
        .search-results {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .results-count {
            font-size: 14px;
            color: #666;
        }

        .sort-options {
            display: flex;
            gap: 10px;
        }

        .sort-btn {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background: white;
            cursor: pointer;
            font-size: 12px;
            border-radius: 4px;
        }

        .sort-btn.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .result-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .result-item:last-child {
            border-bottom: none;
        }

        .result-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .result-title a {
            color: #1a0dab;
            text-decoration: none;
        }

        .result-title a:hover {
            text-decoration: underline;
        }

        .result-url {
            font-size: 14px;
            color: #006621;
            margin-bottom: 5px;
        }

        .result-snippet {
            font-size: 14px;
            color: #545454;
            line-height: 1.4;
        }

        .result-meta {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        /* 페이지네이션 */
        .pagination {
            text-align: center;
            margin-top: 30px;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 2px;
            text-decoration: none;
            color: #007bff;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pagination a:hover {
            background-color: #f8f9fa;
        }

        .pagination .current {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 검색 영역 -->
        <div class="search-header">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="검색어를 입력하세요" value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>">
                <button class="search-btn">검색</button>
                <button class="detail-search-btn">상세검색</button>
            </div>
            
            <div class="search-terms">
                <div class="related-search">
                    <div class="search-section-title">연관검색어</div>
                    <div class="search-tags">
                        <a href="#" class="tag">통합검색</a>
                        <a href="#" class="tag">검색엔진</a>
                        <a href="#" class="tag">검색결과</a>
                        <a href="#" class="tag">검색 최적화</a>
                        <a href="#" class="tag">검색 알고리즘</a>
                    </div>
                </div>
                
                <div class="popular-search">
                    <div class="search-section-title">인기검색어</div>
                    <div class="search-tags">
                        <a href="#" class="tag">1. 검색엔진</a>
                        <a href="#" class="tag">2. 데이터베이스</a>
                        <a href="#" class="tag">3. 웹개발</a>
                        <a href="#" class="tag">4. 자바스크립트</a>
                        <a href="#" class="tag">5. 리액트</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="main-content">
            <!-- 왼쪽 패싯 영역 -->
            <div class="facet-area">
                <div class="facet-section">
                    <div class="facet-title">카테고리</div>
                    <div class="facet-item">
                        <input type="checkbox" id="cat1">
                        <label for="cat1">웹 문서</label>
                        <span class="facet-count">1,234</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="cat2">
                        <label for="cat2">이미지</label>
                        <span class="facet-count">567</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="cat3">
                        <label for="cat3">뉴스</label>
                        <span class="facet-count">89</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="cat4">
                        <label for="cat4">동영상</label>
                        <span class="facet-count">34</span>
                    </div>
                </div>

                <div class="facet-section">
                    <div class="facet-title">날짜</div>
                    <div class="facet-item">
                        <input type="checkbox" id="date1">
                        <label for="date1">최근 1주일</label>
                        <span class="facet-count">245</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="date2">
                        <label for="date2">최근 1개월</label>
                        <span class="facet-count">567</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="date3">
                        <label for="date3">최근 1년</label>
                        <span class="facet-count">1,234</span>
                    </div>
                </div>

                <div class="facet-section">
                    <div class="facet-title">사이트</div>
                    <div class="facet-item">
                        <input type="checkbox" id="site1">
                        <label for="site1">naver.com</label>
                        <span class="facet-count">456</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="site2">
                        <label for="site2">google.com</label>
                        <span class="facet-count">234</span>
                    </div>
                    <div class="facet-item">
                        <input type="checkbox" id="site3">
                        <label for="site3">daum.net</label>
                        <span class="facet-count">123</span>
                    </div>
                </div>
            </div>

            <!-- 오른쪽 검색결과 영역 -->
            <div class="search-results">
                <div class="results-header">
                    <div class="results-count">총 1,234개의 결과 (0.05초)</div>
                    <div class="sort-options">
                        <button class="sort-btn active">관련도순</button>
                        <button class="sort-btn">최신순</button>
                        <button class="sort-btn">제목순</button>
                    </div>
                </div>

                <div class="result-item">
                    <div class="result-title">
                        <a href="#">검색엔진 최적화 가이드 - 효과적인 SEO 전략</a>
                    </div>
                    <div class="result-url">https://example.com/seo-guide</div>
                    <div class="result-snippet">
                        검색엔진 최적화(SEO)는 웹사이트의 검색 결과 순위를 높이는 과정입니다. 키워드 연구, 콘텐츠 최적화, 기술적 SEO 등을 통해 검색 엔진에서 더 나은 가시성을 확보할 수 있습니다...
                    </div>
                    <div class="result-meta">2024-01-15 | 조회수 1,234</div>
                </div>

                <div class="result-item">
                    <div class="result-title">
                        <a href="#">검색엔진의 동작 원리와 알고리즘 이해하기</a>
                    </div>
                    <div class="result-url">https://example.com/search-algorithm</div>
                    <div class="result-snippet">
                        검색엔진은 크롤링, 인덱싱, 랭킹의 3단계 과정을 통해 사용자에게 관련성 높은 결과를 제공합니다. 각 단계의 동작 원리를 이해하면 더 효과적인 검색 전략을 수립할 수 있습니다...
                    </div>
                    <div class="result-meta">2024-01-10 | 조회수 856</div>
                </div>

                <div class="result-item">
                    <div class="result-title">
                        <a href="#">통합검색 시스템 구축 방법과 best practice</a>
                    </div>
                    <div class="result-url">https://example.com/unified-search</div>
                    <div class="result-snippet">
                        통합검색 시스템은 여러 데이터 소스를 하나의 인터페이스로 검색할 수 있게 해주는 시스템입니다. 효율적인 인덱싱, 쿼리 최적화, 사용자 경험 향상을 위한 구현 방법을 소개합니다...
                    </div>
                    <div class="result-meta">2024-01-08 | 조회수 654</div>
                </div>

                <div class="result-item">
                    <div class="result-title">
                        <a href="#">검색 UI/UX 디자인 패턴과 사용자 경험 개선</a>
                    </div>
                    <div class="result-url">https://example.com/search-ux</div>
                    <div class="result-snippet">
                        효과적인 검색 인터페이스 디자인은 사용자가 원하는 정보를 빠르게 찾을 수 있도록 도와줍니다. 자동완성, 필터링, 정렬 기능 등의 구현 방법과 UX 개선 사례를 살펴보겠습니다...
                    </div>
                    <div class="result-meta">2024-01-05 | 조회수 432</div>
                </div>

                <div class="result-item">
                    <div class="result-title">
                        <a href="#">검색 성능 최적화 및 속도 개선 방법</a>
                    </div>
                    <div class="result-url">https://example.com/search-performance</div>
                    <div class="result-snippet">
                        대용량 데이터에서의 검색 성능 최적화는 중요한 과제입니다. 인덱스 구조 최적화, 쿼리 최적화, 캐싱 전략을 통해 검색 속도를 크게 향상시킬 수 있습니다...
                    </div>
                    <div class="result-meta">2024-01-03 | 조회수 321</div>
                </div>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <a href="#" class="current">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#">다음</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 상세검색 팝업 -->
    <div class="popup-overlay" id="detailSearchPopup">
        <div class="popup-content">
            <div class="popup-header">
                <h2 class="popup-title">상세검색</h2>
                <button class="popup-close" type="button">&times;</button>
            </div>
            
            <form id="detailSearchForm">
                <div class="search-form-group">
                    <label class="search-form-label">검색어</label>
                    <input type="text" class="search-form-input" name="keyword" placeholder="검색어를 입력하세요">
                </div>

                <div class="search-form-row">
                    <div class="search-form-group">
                        <label class="search-form-label">제목에서 검색</label>
                        <input type="text" class="search-form-input" name="title" placeholder="제목에 포함될 단어">
                    </div>
                    <div class="search-form-group">
                        <label class="search-form-label">내용에서 검색</label>
                        <input type="text" class="search-form-input" name="content" placeholder="내용에 포함될 단어">
                    </div>
                </div>

                <div class="search-form-row">
                    <div class="search-form-group">
                        <label class="search-form-label">작성자</label>
                        <input type="text" class="search-form-input" name="author" placeholder="작성자명">
                    </div>
                    <div class="search-form-group">
                        <label class="search-form-label">사이트</label>
                        <input type="text" class="search-form-input" name="site" placeholder="example.com">
                    </div>
                </div>

                <div class="search-form-row">
                    <div class="search-form-group">
                        <label class="search-form-label">시작일</label>
                        <input type="date" class="search-form-input" name="startDate">
                    </div>
                    <div class="search-form-group">
                        <label class="search-form-label">종료일</label>
                        <input type="date" class="search-form-input" name="endDate">
                    </div>
                </div>

                <div class="search-form-group">
                    <label class="search-form-label">카테고리</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_web" name="category" value="web">
                            <label for="cat_web">웹 문서</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_image" name="category" value="image">
                            <label for="cat_image">이미지</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_news" name="category" value="news">
                            <label for="cat_news">뉴스</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_video" name="category" value="video">
                            <label for="cat_video">동영상</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_blog" name="category" value="blog">
                            <label for="cat_blog">블로그</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="cat_cafe" name="category" value="cafe">
                            <label for="cat_cafe">카페</label>
                        </div>
                    </div>
                </div>

                <div class="search-form-group">
                    <label class="search-form-label">파일 형식</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="file_pdf" name="fileType" value="pdf">
                            <label for="file_pdf">PDF</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="file_doc" name="fileType" value="doc">
                            <label for="file_doc">DOC</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="file_ppt" name="fileType" value="ppt">
                            <label for="file_ppt">PPT</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="file_xls" name="fileType" value="xls">
                            <label for="file_xls">XLS</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="file_hwp" name="fileType" value="hwp">
                            <label for="file_hwp">HWP</label>
                        </div>
                    </div>
                </div>

                <div class="search-form-group">
                    <label class="search-form-label">언어</label>
                    <select class="search-form-select" name="language">
                        <option value="">전체</option>
                        <option value="ko">한국어</option>
                        <option value="en">영어</option>
                        <option value="ja">일본어</option>
                        <option value="zh">중국어</option>
                    </select>
                </div>

                <div class="search-form-group">
                    <label class="search-form-label">검색 범위</label>
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" id="scope_all" name="scope" value="all" checked>
                            <label for="scope_all">전체</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" id="scope_title" name="scope" value="title">
                            <label for="scope_title">제목만</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" id="scope_content" name="scope" value="content">
                            <label for="scope_content">내용만</label>
                        </div>
                    </div>
                </div>

                <div class="search-form-row">
                    <div class="search-form-group">
                        <label class="search-form-label">정렬 방식</label>
                        <select class="search-form-select" name="sortBy">
                            <option value="relevance">관련도순</option>
                            <option value="date">최신순</option>
                            <option value="title">제목순</option>
                            <option value="popularity">인기순</option>
                        </select>
                    </div>
                    <div class="search-form-group">
                        <label class="search-form-label">결과 수</label>
                        <select class="search-form-select" name="resultsPerPage">
                            <option value="10">10개</option>
                            <option value="20">20개</option>
                            <option value="50">50개</option>
                            <option value="100">100개</option>
                        </select>
                    </div>
                </div>

                <div class="popup-buttons">
                    <button type="button" class="popup-btn popup-btn-outline" id="resetBtn">초기화</button>
                    <button type="button" class="popup-btn popup-btn-secondary" id="closeBtn">취소</button>
                    <button type="submit" class="popup-btn popup-btn-primary">검색</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 검색 기능
        document.querySelector('.search-btn').addEventListener('click', function() {
            const query = document.querySelector('.search-input').value;
            if (query.trim()) {
                // 실제 검색 로직 구현
                console.log('검색어:', query);
                // 여기에 실제 검색 API 호출 코드를 추가하세요
            }
        });

        // 상세검색 팝업 열기
        document.querySelector('.detail-search-btn').addEventListener('click', function() {
            document.getElementById('detailSearchPopup').style.display = 'flex';
        });

        // 상세검색 팝업 닫기
        function closeDetailSearchPopup() {
            document.getElementById('detailSearchPopup').style.display = 'none';
        }

        document.querySelector('.popup-close').addEventListener('click', closeDetailSearchPopup);
        document.getElementById('closeBtn').addEventListener('click', closeDetailSearchPopup);

        // 팝업 외부 클릭 시 닫기
        document.getElementById('detailSearchPopup').addEventListener('click', function(e) {
            if (e.target === this) {
                closeDetailSearchPopup();
            }
        });

        // 상세검색 폼 제출
        document.getElementById('detailSearchForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const searchParams = {};
            
            // 폼 데이터 수집
            for (let [key, value] of formData.entries()) {
                if (value.trim()) {
                    if (searchParams[key]) {
                        if (Array.isArray(searchParams[key])) {
                            searchParams[key].push(value);
                        } else {
                            searchParams[key] = [searchParams[key], value];
                        }
                    } else {
                        searchParams[key] = value;
                    }
                }
            }
            
            console.log('상세검색 조건:', searchParams);
            
            // 기본 검색창에 키워드 반영
            if (searchParams.keyword) {
                document.querySelector('.search-input').value = searchParams.keyword;
            }
            
            // 실제 검색 로직 구현
            // 여기에 상세검색 API 호출 코드를 추가하세요
            
            closeDetailSearchPopup();
        });

        // 초기화 버튼
        document.getElementById('resetBtn').addEventListener('click', function() {
            document.getElementById('detailSearchForm').reset();
        });

        // 엔터키 검색
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.querySelector('.search-btn').click();
            }
        });

        // 정렬 버튼 클릭 이벤트
        document.querySelectorAll('.sort-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.sort-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                console.log('정렬 변경:', this.textContent);
            });
        });

        // 패싯 필터 이벤트
        document.querySelectorAll('.facet-item input[type="checkbox"]').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const label = this.nextElementSibling.textContent;
                console.log('필터 변경:', label, this.checked);
                // 필터 적용 로직 구현
            });
        });

        // 태그 클릭 이벤트
        document.querySelectorAll('.tag').forEach(tag => {
            tag.addEventListener('click', function(e) {
                e.preventDefault();
                const searchTerm = this.textContent.replace(/^\d+\.\s*/, '');
                document.querySelector('.search-input').value = searchTerm;
                document.querySelector('.search-btn').click();
            });
        });
    </script>
</body>
</html>