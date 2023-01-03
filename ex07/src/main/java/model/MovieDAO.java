package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MovieDAO {
	
public void delete(int id) {
		
		try {
			String sql="delete from movie where id=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
			
			
		} catch (Exception e) {
			System.out.println("delete"+e.toString());
		}
	}
	
	
	public ArrayList<MovieVO> list(int page){
		ArrayList<MovieVO> array=new ArrayList<MovieVO>();
		try {
			String sql="select *from movie order by wdate desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				MovieVO vo =new MovieVO();
				vo.setId(rs.getInt("id"));
				vo.setTitle(rs.getString("title"));
				vo.setActor(rs.getString("actor"));
				vo.setDirector(rs.getString("director"));
				vo.setPubDate(rs.getString("pubDate"));
				vo.setLink(rs.getString("link"));
				vo.setImage(rs.getString("image"));
				vo.setWdate(rs.getTimestamp("wdate"));
				array.add(vo);
				
				
			}
		} catch (Exception e) {
			System.out.println("list"+e.toString());
		}
		
		
		return array;
	}
	
	public int count() {
		int count=0;
	try {
		String sql="select count(*) cnt from movie";
		PreparedStatement ps = Database.CON.prepareStatement(sql);
		ResultSet rs=ps.executeQuery();
		if(rs.next()) {
			count=rs.getInt("cnt");
		}
		
	} catch (Exception e) {
		System.out.println("count"+e.toString());
	}
	return count;
	}
	
	
	public void insert(MovieVO vo) {
		
		try {
			String sql="select * from movie where link=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLink());
			ResultSet rs=ps.executeQuery();
			if(!rs.next()) {
				sql="insert into movie(title,image,actor,director,link,pubDate) values(?,?,?,?,?,?)";
				ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getTitle());
				ps.setString(2, vo.getImage());
				ps.setString(3, vo.getActor());
				ps.setString(4, vo.getDirector());
				ps.setString(5, vo.getLink());
				ps.setString(6, vo.getPubDate());
				ps.execute();
			}
			
		} catch (Exception e) {
			System.out.println("insert"+e.toString());
		}
	}

}
