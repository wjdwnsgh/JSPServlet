package real.project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/ShoppingOptions.choice")
public class ShoppingOptions extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 콜백데이터를 JSON객체로 출력하기 위해 객체생성
		JSONObject json = new JSONObject();
		
		// 파라미터를 받은 후 선택한 옵션에 따라 JSON객체 생성
		String gName = req.getParameter("goodsOptionName");
		if(gName.equals("op01")) {
			json.put("optionName", "매우좋은옵션상품");
			json.put("optionPrice", 5000);
		}
		else if(gName.equals("op02")) {
			json.put("optionName", "졸라좋은옵션상품");
			json.put("optionPrice", 7000);
			
		}
		else if(gName.equals("op03")) {
			json.put("optionName", "기깔나는옵션상품");
			json.put("optionPrice", 10000);
			
		}
		
		//앞에서 만든 JSON객체를 문자열로 변환 후 화면에 출력한다.
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.println(json.toJSONString());
		writer.close();
	}
}
