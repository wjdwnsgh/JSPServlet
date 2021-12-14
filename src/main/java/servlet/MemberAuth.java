package servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.MemberDAO;
import membership.MemberDTO;

@WebServlet("/MemberAuth")
public class MemberAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MemberDAO dao;

	// 서블릿 객체 생성시 최초 1번만 호출되는 수명주기 메서드
	@Override
	public void init() throws ServletException {
		/*
		application 내장객체 얻어옴. 모델2 방식에서는 서블릿이 먼저 요청을
		받기 때문에 모델1 방식과 같이 JSP에서 매개변수 형태로 내장객체를 전달할 수 없다.
		따라서 각 내장객체를 얻어올 수 있는 메서드가 존재한다.
		*/
		ServletContext application = this.getServletContext();
		
		// 컨텍스트 초기화 파라미터를 가져온다.
		String driver = application.getInitParameter("OracleDriver");
		String connectUrl = application.getInitParameter("OracleURL");
		String oId = application.getInitParameter("OracleId");
		String oPass = application.getInitParameter("OraclePwd");
		
		// DB연결
		dao = new MemberDAO(driver, connectUrl, oId, oPass);	
	}
	
	/*
	service() 메서드는 get방식, post방식 둘다 요청을 받을 수 있으므로
	해당 메서드 내에서 요청을 처리할 수 있다. 
	*/
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 서블릿 초기화 파라미터를 얻어온다. 해당 서블릿에서만 사용할 수 있다.
		String admin_id = this.getInitParameter("admin_id");
		
		// 파라미터 받아오기
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		// DAO의 회원인증을 위한 메서드 호출
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		// 회원 이름을 통해 로그인 성공 여부를 판단한다.
		String memberName = memberDTO.getName();
		if(memberName != null) {
			// 로그인에 성공한 경우
			req.setAttribute("authMessage", memberName + "회원님 반갑습니다.");
		}
		else {
			// 로그인에 실패한 경우
			if(admin_id.equals(id)) // 초기 파라미터와 비교해서 일치하면 .. 
				req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			else // 일치하는 정보가 전혀 없다면 ..
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다");
		}
		// View로 포워드
		req.getRequestDispatcher("/13Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	// 서블릿 종료시 소멸
	@Override
	public void destroy() {
		dao.close();
	}

	
	

}
