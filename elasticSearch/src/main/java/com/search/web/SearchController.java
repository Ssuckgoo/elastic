package com.search.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.search.SearchVO;
import com.search.searvice.SearchService;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.core.SearchResponse;

@Controller 
public class SearchController {

	@Autowired
	private SearchService searchService;
	
    /*
     * 검색
     * @param searchVO: 검색 조건.
     * @return SearchResponse: ES가  전송한 검색 결과. Java에서는 받은 값을 그대로 client(ajax)에 전송. 모든 처리를 JS에서 진행
     */
    @RequestMapping("/search/search4Ajax.do")
    public void search4Ajax(HttpServletRequest HttpRequest, HttpServletResponse HttpResponse) {
    	
    	try {
    		
	    	ElasticsearchClient esClient = ElasticsearchClient.of(b -> b
				.host("http://192.168.0.58:9200")
			);
	
	    	String searchText = "개발팀";
	
//	    	SearchResponse<SearchVO> response = esClient.search(s -> s
//	    	        .index("test_users")
//	    	        .query(q -> q
//	    	            .match(t -> t
//	    	                .field("department")
//	    	                .query(searchText)
//	    	            )
//	    	        ),
//	    	        SearchVO.class
//	    	);
    	
	    	esClient.close();
	    	
	    	
    	}catch(Exception e) {
    		
    	} 
    	
    }
    
    /*
     * 검색식 작성
     * @param fields: 검색할 필드.
     * @param words: 검색할 키워드.
     * @param searchVO: 검색 조건. 데이터 소스 종류(searchType), 날짜(getSearchTerm).
     */
//    private BoolQueryBuilder makeQuery (String[] fields, String[] words, FullTextSearchVO searchVO) {
//    	BoolQueryBuilder qb = QueryBuilders.boolQuery();
//    	
//    	String searchType = searchVO.getSearchType();
//    	if (searchType!=null & !"".equals(searchType)) {
//    		qb.must(QueryBuilders.termQuery("bgno", searchType));
//    	}
//    	
//    	if (!"a".equals(searchVO.getSearchTerm())) {							// 기간 검색
//    		qb.must(QueryBuilders.rangeQuery("brddate").from( searchVO.getSearchTerm1()).to( searchVO.getSearchTerm2()) );	
//    	}
//
//    	for( String word : words) {			// 검색 키워드
//    		word = word.trim().toLowerCase();
//    		if ("".equals(word)) continue;
//    		
//        	BoolQueryBuilder qb1 = QueryBuilders.boolQuery();
//        	for( String fld : fields) {							// 입력한 키워드가 지정된 모든 필드에 있는지 조회
//        		if ("brdreply".equals(fld)) {		// 댓글은 nested로 저장되어 있어 별도로 작성
//                	 qb1.should(QueryBuilders.nestedQuery("brdreply", QueryBuilders.boolQuery().must(QueryBuilders.termQuery("brdreply.rememo", word)), ScoreMode.None));
//        		} else 
//            	if ("brdfiles".equals(fld)) {		// 첨부 파일은  nested로 저장되어 있어 별도로 작성
//                   	 qb1.should(QueryBuilders.nestedQuery("brdfiles", QueryBuilders.boolQuery().must(QueryBuilders.termQuery("brdfiles.filememo", word)), ScoreMode.None));
//           		} else {
//        			qb1.should(QueryBuilders.boolQuery().must(QueryBuilders.termQuery(fld, word)));
//        		}
//        	}
//        	
//        	qb.must(qb1);			// 검색 키워드가 여러개일 경우 and로 검색
//    	}
//    	
//		return qb;
//    }
//    /*
//     * Highlight 필드 지정
//     * @param fields: 필드
//     */
//    private HighlightBuilder makeHighlightField (String[] fields) {
//    	HighlightBuilder highlightBuilder = new HighlightBuilder(); 
//		
//    	for( String fld : fields) {
//    		if ("brdreply".equals(fld) || "brdfiles".equals(fld)) continue; 	// 댓글, 첨부파일은 하이라이트 안함. 댓글, 첨부파일이 검색되어도 부모글이 출력되기 때문
//        	HighlightBuilder.Field hField = new HighlightBuilder.Field(fld); 
//        	highlightBuilder.field(hField);  
//    	}
//    	
//		return highlightBuilder;
//    }
//
//
//    // ---------------------------------------------------------------------------
//    public RestHighLevelClient createConnection() {
//        return new RestHighLevelClient(
//                    RestClient.builder(
//                            new HttpHost("localhost", 9200, "http")
//                    )
//                );
//    }
//    // ---------------------------------------------------------------------------
}
 
