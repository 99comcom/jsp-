package model;
import java.sql.*;
import java.util.*;

public class UserDAO {
	Connection CON=Database.CON;
	//전체데이타갯수
	public int count() {
		int count=0;
		try {
			String sql="select count(*) cnt from userinfo";
			PreparedStatement ps=CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				count=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("전체데이터갯수:" + e.toString());
		}
		return count;
	}
	
	//사용자수정
	public void update(UserVO vo) {
		try {
			String sql="update userinfo set name=?,password=? where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(3, vo.getId());
			ps.setString(2, vo.getPassword());
			ps.setString(1, vo.getName());
			ps.execute();
		}catch(Exception e) {
			System.out.println("사용자수정:" + e.toString());
		}
	}
	
	//사용자삭제
	public void delete(String id, String del) {
		try {
			String sql="update userinfo set del=? where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, del);
			ps.setString(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("사용자삭제:" + e.toString());
		}
	}
	
	//사용자등록
	public void insert(UserVO vo) {
		try {
			String sql="insert into userinfo(id,password,name) values(?,?,?)";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPassword());
			ps.setString(3, vo.getName());
			ps.execute();
		}catch(Exception e) {
			System.out.println("사용자등록:" + e.toString());
		}
	}
	
	//사용자정보
	public UserVO read(String id) {
		UserVO vo=new UserVO();
		try {
			String sql="select * from userinfo where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setId(rs.getString("id"));
				vo.setPassword(rs.getString("password"));
				vo.setName(rs.getString("name"));
			}
		}catch(Exception e) {
			System.out.println("사용자정보:" + e.toString());
		}
		return vo;
	}
	
	//사용자목록
	public ArrayList<UserVO> list(int page){
		ArrayList<UserVO> array=new ArrayList<UserVO>();
		try {
			int start=(page-1) * 3;
			String sql="select * from userinfo order by id limit ?,3";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setInt(1, start);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				UserVO vo=new UserVO();
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setDel(rs.getString("del"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("사용자목록:" + e.toString());
		}
		return array;
	}
}
