package fileupload;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {

	//파일업로드 처리
	public static MultipartRequest uploadFile(HttpServletRequest req,
			String saveDirectory, int maxPostSize) {
		try {
			/*
			 	MultipartRequest(request내장객체, 디렉토리의 물리적경로, 파일제한용량, 인코딩방식)
				객체를 생성함과 동시에 파일은 업로드가 완료되어 서버에 저장된다.
				업로드가 성공하면 객체의 참조값을 반환한다.
			*/
			return new MultipartRequest(req, saveDirectory, maxPostSize, "UTF-8");
		}
		catch (Exception e) {
			/*
			 	업로드에 실패하는 경우는 용량초과, 디렉토리 경로 오류등이 대부분이다.
			 	이때는 null값을 반환한다.
			*/
			e.printStackTrace();
			return null;
		}
	}
}
