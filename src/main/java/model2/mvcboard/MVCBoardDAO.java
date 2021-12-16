package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool{

	// 기본 생성자는 없어도 동작에는 영향이 없다.
	public MVCBoardDAO() {
		super();
	}
	
	// 검색조건에 맞는 게시물의 개수를 반환
	public int selectCount(Map<String, Object> map) {
		//카운트 변수
		int totalCount = 0;
		//쿼리문 작성
		String query = "SELECT COUNT(*) FROM mvcboard";
		//검색어가 있는 경우 where절을 동적으로 추가한다.
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			//정적쿼리문(?가 없는 쿼리문) 실행을 위한 Statement 객체 생성
			stmt = con.createStatement();
			// select 쿼리문을 실행 후 ResultSet객체를 반환받음
			rs = stmt.executeQuery(query);
			// 커서를 이동시켜 결과데이터를 읽음
			rs.next();
			// 결과값을 변수에 저장
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		// 3개의 서브 쿼리문을 통한 페이지 처리
		String query = " SELECT * FROM ( "
					 + "   SELECT Tb.*, ROWNUM rNum FROM ( "
					 + "      SELECT * FROM mvcboard ";
		
		// 검색 조건 추가 (검색어가 있는 경우에만 where절이 추가됨)
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		query += "       ORDER BY idx DESC "
				+ "     ) Tb"
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		/* JSP에서 계산된 게시물의 구간을 인파라미터로 처리함 */
		
		try {
			// 쿼리 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			// 인파라미터 설정 : 구간을 위한 start, end를 설정함
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			// 쿼리문 실행
			rs = psmt.executeQuery();
			
			// select한 게시물의 갯수만큼 반복함
			while (rs.next()) {
				// 한 행(게시물 하나)의 데이터를 DTO에 저장
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				//반환할 결과 목록에 게시물 추가
				board.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	//새로운 게시물에 대한 입력처리
	public int insertWrite(MVCBoardDTO dto) {
		// 입력결과 확인용 변수
		int result = 0;
		
		try {
			// 인파라미터가 있는 쿼리문 작성(동적쿼리문)
			String query = " INSERT INTO mvcboard( "
						 + " idx, name, title, content, ofile, sfile, pass) "
						 + " VALUES ( "
						 + " seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			
			// 동적쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			// 순서대로 인파라미터 설정			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			//쿼리문 실행 : 입력에 성공한다면 1이 반환된다 실패시 0 반환
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
}
