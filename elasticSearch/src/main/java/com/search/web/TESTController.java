package com.search.web;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.elasticsearch.client.RestClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.search.UserVO;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.query_dsl.MatchPhraseQuery;
import co.elastic.clients.elasticsearch._types.query_dsl.MatchQuery;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Highlight;
import co.elastic.clients.elasticsearch.core.search.HighlightField;
import co.elastic.clients.elasticsearch.core.search.Hit;
import co.elastic.clients.json.jackson.JacksonJsonpMapper;
import co.elastic.clients.transport.rest_client.RestClientTransport;

@Controller 
public class TESTController {
	
	private static final String INDEX_NAME = "test_users";
	private static final String ELASTIC_ID = "admin";
	private static final String ELASTIC_PW = "qwer1234";
	private static final String ELASTIC_IP = "192.168.0.58";
	private static final int ELASTIC_PORT = 9200;
	private static final String ELASTIC_PROTOCAL = "HTTP";
	

	private static ElasticsearchClient client;
	
	private static ElasticsearchClient createClient() {
		
		if (client != null) return client;
		
		BasicCredentialsProvider credentials = new BasicCredentialsProvider();
		
		// credential(ID, Password) 정보 생성
        credentials.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(ELASTIC_ID, ELASTIC_PW));

        RestClient restClient = RestClient.builder(
            new HttpHost(ELASTIC_IP, ELASTIC_PORT, ELASTIC_PROTOCAL) // 내 서버 IP:PORT
        )
		.setHttpClientConfigCallback(httpAsyncClientBuilder -> httpAsyncClientBuilder
                .setDefaultCredentialsProvider(credentials)	// credential 추가
        )		
		.build();
        
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule()); // LocalDate 지원
        JacksonJsonpMapper jsonpMapper = new JacksonJsonpMapper(objectMapper);
        RestClientTransport transport = new RestClientTransport(restClient, jsonpMapper);

//        RestClientTransport transport = new RestClientTransport(
//            restClient, new JacksonJsonpMapper()
//        );

        client = new ElasticsearchClient(transport);
        
        return client;
	}
	
	
	//통합검색
	@GetMapping("/xhdgkq.do")
	public void xhdgkq(HttpServletRequest request,HttpServletResponse response){
		
		
		
		
		ElasticsearchClient client = createClient();
		
		
	}

	@RequestMapping("/elasticTest.do")
    public void elasticTest() {
		
		ElasticsearchClient client = createClient();
		
//        List<Query> queryList = new ArrayList<>(createMatchQueryList(FIELD_NAME, fieldSuffixes, boostValueByMultiFieldMap, keyword).stream().map(MatchQuery::_toQuery).toList());
//        
//        DisMaxQuery disMaxQuery = new DisMaxQuery.Builder()
//                .queries(queryList)
//                .build();
        
        
//        SearchRequest searchRequest = SearchRequest.of(s -> s
//                .index("lecture")
//                .query(query -> query
//                        .bool(bool -> bool
//                                .must(m -> m
//                                        .match(match -> match
//                                                .field(f)
//                                                .query(q)))
//                                .filter(m -> m
//                                        .range(r -> r.field("date")
//                                                .from(LocalDate.now().toString())
//                                                .to(LocalDate.now().toString())))))
//                .routing(q));        
        
        try {
        	
//	        SearchResponse<UserVO> response = client.search(s -> s
//	                .index(INDEX_NAME)
//	                .size(100)
//	                .query(q -> q
//	                    .match(t -> t
//	                        .field("department")
//	                        .query("개발팀")
//	                    )
//	                ), UserVO.class);
	        
	        SearchResponse<UserVO> response = client.search(s -> s
	                .index(INDEX_NAME)
	                .size(100)
	                .query(q -> q
	                	.bool(bool -> bool
	                			.mustNot(m -> m
	                					.term(t -> t
	                							.field("department")
	                							.value("개발팀")
	                							)
	                					
	                					)
	                			)
	                ), UserVO.class);
	        
	        	System.out.println("총데이터 갯수 "+response.hits().total().value());
	            for (Hit<UserVO> hit : response.hits().hits()) {
	                System.out.println(hit.source());
	            }
            
        } catch(Exception e) {
        	e.printStackTrace();
        }
        
    }
	
	 private MatchQuery createMatchQuery(String keyword, String fieldName, Float boostValue) {
	        return new MatchQuery.Builder()
	                .query(keyword)
	                .field(fieldName)
	                .boost(boostValue)
	                .build();
    }
	 
    private MatchPhraseQuery createMatchPhraseQuery(String keyword, String fieldName, Float boostValue) {
        return new MatchPhraseQuery.Builder()
                .query(keyword)
                .field(fieldName)
                .boost(boostValue)
                .build();
    }

    // https://stackoverflow.com/questions/71351777/how-to-explicitly-order-highlighted-fields-using-elasticsearch-java-api-client
    private Highlight createHighlightFieldMap(List<String> fieldNames) {
        Map<String, HighlightField> highlightFieldMap = new HashMap<>();
        for (String fieldName : fieldNames) {
            highlightFieldMap.put(
                    fieldName,
                    new HighlightField.Builder().postTags("</strong>").preTags("<strong>").build()
            );
        }
        return new Highlight.Builder().fields(highlightFieldMap).build();
    }	 
	
    private List<MatchQuery> createMatchQueryList(String fieldName, String[] fieldSuffixes, Map<String, Float> boostValueByMultiFieldMap, String keyword) {
        return Arrays.stream(fieldSuffixes)
                .flatMap(fieldSuffix -> boostValueByMultiFieldMap.entrySet().stream()
                        .map(boostValueByMultiFieldEnt -> {
                            String multiField = boostValueByMultiFieldEnt.getKey();
                            Float boostValue = boostValueByMultiFieldEnt.getValue();
                            return createMatchQuery(keyword, fieldName + fieldSuffix + multiField, boostValue);
                        }))
                .collect(Collectors.toList());
    }
    
	
}
