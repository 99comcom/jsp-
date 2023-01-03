package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ShopDAO {
	//Max ID 구하기
	public String newId() {
		String  newId="";
		try {
			String sql="select max(id) from shop";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String maxId=rs.getString("max(id)").trim();
				long id=Long.parseLong(maxId) + 1;
				newId = String.valueOf(id);
			}
		}catch(Exception e) {
			System.out.println("MaxID:" + e.toString());
		}
		return newId;
	}
	
	//전체데이터갯수
	public int count() {
		int count=0;
		try {
			String sql="select count(*) from shop";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) count=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("전체데이터수:" + e.toString());
		}
		return count;
	}
	
	//상품목록
	public ArrayList<ShopVO> list(int page){
		ArrayList<ShopVO> array=new ArrayList<ShopVO>();
		try {
			String sql="select *,date_format(wdate,'%Y-%m-%d %T') fdate";
			sql+= " from shop order by wdate desc limit ?,5";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ShopVO vo=new ShopVO();
				vo.setId(rs.getString("id"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setBrand(rs.getString("brand"));
				vo.setImage(rs.getString("image"));
				vo.setWdate(rs.getString("fdate"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("상품목록:" + e.toString());
		}
		return array;
	}
	//상품등록
	public void insert(ShopVO vo) {
		try {
			String sql="select * from shop where id=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ResultSet rs=ps.executeQuery();
			if(!rs.next()) {
				sql="insert into shop(id,title,image,price,brand) values(?,?,?,?,?)";
				ps=Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getId());
				ps.setString(2, vo.getTitle());
				ps.setString(3, vo.getImage());
				ps.setInt(4, vo.getPrice());
				ps.setString(5, vo.getBrand());
				ps.execute();
			}
		}catch(Exception e) {
			System.out.println("상품등록:" + e.toString());
		}
	}
}
