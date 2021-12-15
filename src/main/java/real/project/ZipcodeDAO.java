package real.project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.DBConnPool;

public class ZipcodeDAO extends DBConnPool{
	
	public ArrayList<String> getSido() {
		ArrayList<String> sidoAddr = new ArrayList<String>();
		
		String sql = "SELECT distinct sido FROM zipcode "
				+ " WHERE 1=1"
				+ " ORDER BY sido ASC";
		System.out.println("sql="+ sql);
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				sidoAddr.add(rs.getString(1));
			}
		}
		catch (Exception e) {
			
		}
		return sidoAddr;
	}
	
	public ArrayList<String> getGugun(String sido) {
		ArrayList<String> gugunAddr = new ArrayList<String>();
		
		String sql = "SELECT DISTINCT gugun FROM zipcode "
				+ " WHERE sido=?"
				+ " ORDER BY gugun DESC";
		System.out.println("sql="+ sql);
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, sido);
			rs = psmt.executeQuery();
			while(rs.next()) {
				gugunAddr.add(rs.getString(1));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return gugunAddr;
	}
	
}
