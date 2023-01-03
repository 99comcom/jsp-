package model;
import java.sql.*;
import java.util.*;

public class UserDAO {
	Connection CON=Database.CON;
	//��ü����Ÿ����
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
			System.out.println("��ü�����Ͱ���:" + e.toString());
		}
		return count;
	}
	
	//����ڼ���
	public void update(UserVO vo) {
		try {
			String sql="update userinfo set name=?,password=? where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(3, vo.getId());
			ps.setString(2, vo.getPassword());
			ps.setString(1, vo.getName());
			ps.execute();
		}catch(Exception e) {
			System.out.println("����ڼ���:" + e.toString());
		}
	}
	
	//����ڻ���
	public void delete(String id, String del) {
		try {
			String sql="update userinfo set del=? where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, del);
			ps.setString(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("����ڻ���:" + e.toString());
		}
	}
	
	//����ڵ��
	public void insert(UserVO vo) {
		try {
			String sql="insert into userinfo(id,password,name) values(?,?,?)";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPassword());
			ps.setString(3, vo.getName());
			ps.execute();
		}catch(Exception e) {
			System.out.println("����ڵ��:" + e.toString());
		}
	}
	
	//���������
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
			System.out.println("���������:" + e.toString());
		}
		return vo;
	}
	
	//����ڸ��
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
			System.out.println("����ڸ��:" + e.toString());
		}
		return array;
	}
}
