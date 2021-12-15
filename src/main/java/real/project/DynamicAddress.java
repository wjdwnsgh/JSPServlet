package real.project;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

@WebServlet("/DynamicAddress.do")
public class DynamicAddress extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 시/도를 파라미터로 받음
		String sido = req.getParameter("sido");
		ZipcodeDAO dao = new ZipcodeDAO();
		// 파라미터에 해당하는 구/군을 List컬렉션으로 반환
		ArrayList<String> gugunList = dao.getGugun(sido);
		// JSON배열로 생성하기 위해 객체 생성
		JSONArray jsonArr = new JSONArray();
		//List컬렉션에 저장된 구/군의 갯수만큼 반복해서 JSON배열에 추가
		for (String gu : gugunList) {
			jsonArr.add(gu); // List컬렉션과 사용법이 동일
		}
		dao.close();
		
		// 서블릿에서 즉시 출력
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.println(jsonArr.toJSONString());
		writer.close();
	}
}
