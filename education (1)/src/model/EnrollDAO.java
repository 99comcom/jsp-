package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class EnrollDAO {
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	//특정강좌의 특정학생의 점수수정
	public void update(String lcode, String scode, int grade) {
		try {
			String sql="update enrollments set grade=? where lcode=? and scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, grade);
			ps.setString(2, lcode);
			ps.setString(3, scode);
			ps.execute();
		}catch(Exception e) {
			System.out.println("점수수정:" + e.toString());
		}
	}
	
	//수강취소
	public void delete(String lcode, String scode) {
		try {
			String sql = "delete from enrollments where lcode = ? and scode = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.setString(2, scode);
			ps.execute();
			
			sql = "update courses set persons = persons - 1 where lcode = ?";
			ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
		} catch (Exception e) {
			System.out.println("취소 : " + e.toString());
		}
	}
	
	//수강신청
	public void insert(String lcode, String scode) {
		try {
			String sql = "insert into enrollments(lcode,scode) values(?,?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.setString(2, scode);
			ps.execute();
			
			sql = "update courses set persons = persons + 1 where lcode = ?";
			ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.execute();
		} catch (Exception e) {
			System.out.println("등록 : " + e.toString());
		}
	}
	
	//강좌 중복 체크
	public int check(String lcode, String scode) {
		int count = 0;
		
		try {
			String sql = "select count(*) from enrollments where lcode = ? and scode = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ps.setString(2, scode);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch(Exception e) {
			System.out.println("중복 체크 : " + e.toString());
		}
		
		return count;
	}
	
	//모든 강좌 목록
	public JSONArray alist() {
		JSONArray jArray = new JSONArray();
		
		try {
			String sql = "select * from cou";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("pname", rs.getString("pname"));
				obj.put("persons", rs.getInt("persons"));
				obj.put("capacity", rs.getInt("capacity"));
				jArray.add(obj);
			}
		} catch(Exception e) {
			System.out.println("강좌목록 : " + e.toString());
		}		
		return jArray;
	}
	
	//특정 강좌의 학생목록
	public JSONArray slist(String lcode) {
		JSONArray array=new JSONArray();
		try {
			String sql="select * from estu where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("year", rs.getString("year"));
				String edate=sdf2.format(rs.getDate("edate"));
				obj.put("edate", edate);
				obj.put("grade", rs.getInt("grade"));
				array.add(obj);
			}
		}catch(Exception e) {
			System.out.println("학생목록:" + e.toString());
		}
		return array;
	}
	
	//특정 학생의 수강신청 목록
	public JSONArray clist(String scode) {
		JSONArray jArray = new JSONArray();
		try {
			String sql = "select * from ecou where scode = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("edate", sdf2.format(rs.getDate("edate")));
				obj.put("pname", rs.getString("pname"));
				obj.put("room", rs.getString("room"));
				obj.put("hours", rs.getInt("hours"));
				obj.put("persons", rs.getInt("persons"));
				obj.put("capacity", rs.getInt("capacity"));
				jArray.add(obj);
			}
		} catch(Exception e) {
			System.out.println("수강신청목록 : " + e.toString());
		}
		return jArray;
	}
}
