package model;
import java.sql.*;
import java.util.ArrayList;
public class LocalDAO {
	Connection con=Database.CON;
	
	public int count (){
		int count=0;
		
		try {
			String sql="select count(*) cnt from local ";
			PreparedStatement ps =con.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				count=rs.getInt("cnt");
			}	
		} catch (Exception e) {
			System.out.println("count" +e.toString());
		}
		return count;
	}
	
	
	
	
	
	public ArrayList<LocalVO> list(int page){
		ArrayList<LocalVO> array= new ArrayList<LocalVO>();
		
		try {
			String sql="select * from local order by wdate desc limit ?,7";
			PreparedStatement ps =con.prepareStatement(sql);
			ps.setInt(1,(page-1)*7);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				LocalVO vo = new LocalVO();
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setAddress(rs.getString("address"));
				vo.setPhone(rs.getString("phone"));
				vo.setKeyword(rs.getString("keyword"));
				vo.setX(rs.getDouble("x"));
				vo.setY(rs.getDouble("y"));
				vo.setWdate(rs.getTimestamp("wdate"));
				array.add(vo);
			}	
		} catch (Exception e) {
			System.out.println("list" +e.toString());
		}
		return array;
	}
	
	
	
	
	
	//지역등록 
	public void insert(LocalVO vo) {
		try {
			String sql="select * from local where id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ResultSet rs=ps.executeQuery();
			if(!rs.next()) {
				sql="insert into local(id,name,address,phone,keyword,x,y) values(?,?,?,?,?,?,?)";
				ps=con.prepareStatement(sql);
				ps.setString(1, vo.getId());
				ps.setString(2, vo.getName());
				ps.setString(3, vo.getAddress());
				ps.setString(4, vo.getPhone());
				ps.setString(5, vo.getKeyword());
				ps.setDouble(6, vo.getX());;
				ps.setDouble(7, vo.getY());;
				ps.execute();
				
			}
			
		} catch (Exception e) {
			System.out.println("insert"+e.toString());
		}
		
	}

}
