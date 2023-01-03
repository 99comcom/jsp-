package model;

import java.sql.*;

import org.json.simple.*;

public class AddressDAO {
	Connection CON=Database.CON;
	
	//林家沥焊
	public AddressVO read(int id) {
		AddressVO vo=new AddressVO();
		try {
			String sql="select * from address where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setId(rs.getInt("id"));
				vo.setName(rs.getString("name"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
			}
		}catch(Exception e) {
			System.out.println("林家沥焊:" + e.toString());
		}
		return vo;
	}
	
	//林家昏力
	public void delete(int id) {
		try {
			String sql="delete from address where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("昏力:" + e.toString());
		}
	}
	
	//林家格废单捞磐 (JSON)
	public JSONObject list() {
		JSONObject object=new JSONObject();
		try {
			String sql="select * from address order by id desc";
			PreparedStatement ps=CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("id", rs.getInt("id"));
				obj.put("name", rs.getString("name"));
				obj.put("tel", rs.getString("tel"));
				obj.put("address", rs.getString("address"));
				array.add(obj);
			}
			object.put("array", array);
		}catch(Exception e) {
			System.out.println("林家格废:" + e.toString());
		}
		return object;
	}
	
	//林家殿废
	public void insert(AddressVO vo) {
		try {
			String sql="insert into address(name,tel,address) values(?,?,?)";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTel());
			ps.setString(3, vo.getAddress());
			ps.execute();
		}catch(Exception e) {
			System.out.println("林家殿废:" + e.toString());
		}
	}
	
	//林家荐沥
	public void update(AddressVO vo) {
		try {
			String sql="update address set name=?,tel=?,address=? where id=?";
			PreparedStatement ps=CON.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getTel());
			ps.setString(3, vo.getAddress());
			ps.setInt(4, vo.getId());
			ps.execute();
		}catch(Exception e) {
			System.out.println("林家荐沥:" + e.toString());
		}
	}
}
