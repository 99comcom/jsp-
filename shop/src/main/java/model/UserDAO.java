package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	public UserVO login(String uid) {
		UserVO vo=new UserVO();
		try {
			String sql="select * from users where uid=?";
			PreparedStatement ps = Data.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setPass(rs.getString("pass"));
				vo.setUname(rs.getString("uname"));
			}
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		return vo;
	}

}
