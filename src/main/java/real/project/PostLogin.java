package real.project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import membership.MemberDAO;
import membership.MemberDTO;

@WebServlet("/realproject/PostLogin.do")
public class PostLogin extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 폼값 받기
		String id = req.getParameter("user_id");
		String pw = req.getParameter("user_pw");
		
		// 서블릿에서 application 내장객체를 얻어옴
		ServletContext application = this.getServletContext();
		//DAO객체 생성
		MemberDAO dao = new MemberDAO(application);
		// 회원인증이 완려더;먄 장벌,ㄹ DTO에 저장한 후 반환
		MemberDTO dto = dao.getMemberDTO(id, pw);
		/*
		JSP에서 JSON을 생성하기 위해 확장 라이브러리가 추가적으로 필요하다.
		json-simple-1.1.1.jar 파일을 다운로드 한 후 lib 폴더에 추가한다. 
		*/
		// JSON객체를 생성하기 위한 객체
		JSONObject json = new JSONObject();
		
		//DTO객체를 통해 회원의 이름이 있는지 확인해서..
		if(dto.getName()!= null) { // 있다면 로그인 성공
			json.put("result", 1);
			json.put("message", dto.getName()+"님, 로그인 성공입니다^^*");
			
			//JSON객체에 저장할 값은 아래와 같이 HTML태그도 가능하다.
			String html = "";
			html+="<table class='table table-bordered' style='width:300px'>";
			html+="  <tr>";
			html+="    <td>"+dto.getName()+"회원님, 반갑습니다^^*</td>";
			html+="  </tr>";
			html+="</table>";
			json.put("html", html);
			
		}
		else { // 없다면 .. 로그인 실패
			json.put("result", 0);
			json.put("message", "로그인 실패입니다.ㅜㅜ");
		}
		
		dao.close(); // 자원해제
		// 앞에서 생성한 JSOn객체를 String으로 변환한다.
		String jsonStr = json.toJSONString();
		//서블릿에서 JSON을 즉시 출력하기 위해 컨텐츠 타입 설정
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		// 출력
		writer.println(jsonStr);
		writer.close();
	}
}
