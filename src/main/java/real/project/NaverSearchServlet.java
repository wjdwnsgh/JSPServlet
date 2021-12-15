package real.project;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 어노테이션을 통한 요청명 매핑. (항상 컨텍스트 루트 경로를 제외한 / 로 시작하는 경로명을 써야함)
@WebServlet("/NaverSearchAPI.do")
public class NaverSearchServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 네이버 개발자 센터에서 발급받는 API Key 입력
		String clientId = "BHlhwCAdfvhCHPSrBkk_"; //애플리케이션 클라이언트 아이디값"
        String clientSecret = "kPWBcDhO08"; //애플리케이션 클라이언트 시크릿값"
        
        //클라이언트가 입력한 검색어와 페이지번호를 파라미터로 받아줌. 
        String keyword = req.getParameter("keyword");
        int startNum = Integer.parseInt(req.getParameter("startNum"));

        // 검색API의 용청 URL
        /*
         	파라미터 설명(API Document참고할 것)
         		query : 검색어(필수사항)
         		display : 출력할 결과의 갯수(디폴트:10)
         		start : 출력할 결과의 시작 페이지(디폴트:1)
        */
        String text = null;
        try {
        	// 클라이언트가 입력한 검색어로 대체함
            text = URLEncoder.encode(keyword, "UTF-8");
        } 
        catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/blog?query="+text+"&display=20&start="+startNum;    // json 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과


        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);


        //네이버 검색 APi 실행시 결과값을 로그로 출력한다.
        System.out.println(responseBody);
        
        // 검색결과를 JSOn으로 내려받아 서블릿에서 즉시 화면에 출력한다.
        resp.setContentType("text/html;charset=utf-8");
        resp.getWriter().write(responseBody);
		
	}
	///////////////////////////////////////////////////////////////////
	// 아래 3개의 메서드는 원본 그대로 사용한다.
	////////////////////////////////////////////////////////////////////
	


    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
}
