package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet{
	
	//수정페이지 진입부분
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 일련번호 파라미터 받기
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		// 게시물 가져오기
		MVCBoardDTO dto = dao.selectView(idx);
		// DTO객체를 리퀘스트 영역에 저장
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVCBoard/Edit.jsp").forward(req, resp);
	}
	
	// 수정처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 물리적 경로 얻어오기
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		
		// 업로드 제한 용량 얻어오기
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		
		//파일 업로드 
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		
		// 업로드에 실패한 경우..(파일을 첨부하지 않더라도 객체는 생성된다.)
		if(mr==null) {
			// 경고창을 띄우고 쓰기 페이지로 이동
			JSFunction.alertLocation(resp, "첨부파일이 제한용량을 초과합니다.",
					"../mvcboard/write.do");
			return;
		}
		
		// 폼값 저장
		String idx = mr.getParameter("idx"); // 일련번호
		// 새롭게 등록된 파일이 없는경우 Query문에 사용함
		String prevOfile = mr.getParameter("prevOfile"); // 기존 DB에 등록된 파일명
		String prevSfile = mr.getParameter("prevSfile"); // 기존 DB에 등록된 저장된파일명
		
		//수정페이지에서 새롭게 입력한 폼값
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		//패스워드 검증시 session영역에 저장된 속성값 가져와서 DTO에 저장
		HttpSession session = req.getSession();
		String pass = (String)session.getAttribute("pass");
		
		//DTO에 데이터 세팅
		MVCBoardDTO dto = new MVCBoardDTO();
		dto.setIdx(idx);
		dto.setName(name);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPass(pass);
		
		// 새롭게 저장된 파일이 있는지 확인하기 위해 파일명을 얻어옴
		String fileName = mr.getFilesystemName("ofile");
		// 서버에 저장된 파일이 있는경우 아래 처리를 한다.
		if(fileName != null) { // 새롭게 등록된 파일이 있으면...
			// 저장할 파일명 생성
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newFileName = now + ext;
			// 파일명을 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			// DTO에 기존파일명과 변경된파일명 저장
			oldFile.renameTo(newFile);
			dto.setOfile(fileName);
			dto.setSfile(newFileName);
			
			// 새로운 파일이 등록되었으므로 기존에 등록한 파일은 삭제처리
			FileUtil.deleteFile(req, "/Uploads", prevSfile);		
			
		}
		else { // 새롭게 등록한 파일이 없는경우..
			// 기존에 등록한 파일명을 유지한다.
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		//DB 업데이트 처리
		MVCBoardDAO dao = new MVCBoardDAO();
		int result = dao.updatePost(dto);
		// 커넥션풀 자원 반납
		dao.close();
		
		if(result == 1) { // 수정이 완료되었다면..
			// 세션영역에 저장된 패스워드 삭제
			session.removeAttribute("pass");
			// 상세보기 페이지로 이동
			resp.sendRedirect("../mvcboard/view.do?idx=" + idx);
		}
		else { // 수정에 실패한 경우 ..
			// 상세보기 페이지로 이동하여 비밀번호 검증을 다시 하도록 한다.
			JSFunction.alertLocation(resp, "비밀번호 검증을 다시 진행해주세요", "../mvcboard/view.do?idx=" + idx);
		}
	}
}
