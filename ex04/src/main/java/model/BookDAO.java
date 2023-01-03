package model;
import java.sql.*;
import java.util.ArrayList;

public class BookDAO {
	Connection con=Database.CON;
	
	   //도서갯수
	   public int count() {
	      int count=0;
	      try {
	         String sql="select count(*) cnt from books";
	         PreparedStatement ps=Database.CON.prepareStatement(sql);
	         ResultSet rs=ps.executeQuery();
	         
	         if(rs.next()) {
	            count=rs.getInt("cnt");
	         }
	      }catch(Exception e) {
	         System.out.println("도서갯수:" + e.toString());
	      }
	      return count;
	   }
	
	
	
 public ArrayList<BookVO> list (int page){
	 ArrayList<BookVO> array= new ArrayList<BookVO>();
	 try {
		 String sql="select *,date_format(wdate,'%Y-%m-%d %T') fdate from books order by id desc limit ?,5";
		 PreparedStatement ps=con.prepareStatement(sql);
		 ps.setInt(1,(page-1)*5);
		 ResultSet rs=ps.executeQuery();
		 
		 while(rs.next()) {
			 BookVO vo=new BookVO();
			 vo.setId(rs.getInt("id"));
			 vo.setTitle(rs.getString("title"));
			 vo.setContents(rs.getString("contents"));
			 vo.setWdate(rs.getString("fdate"));
			 vo.setPublisher(rs.getString("publisher"));
			 vo.setAuthors(rs.getString("authors"));
			 vo.setIsbn(rs.getString("isbn"));
			 vo.setImage(rs.getString("image"));
			 vo.setPrice(rs.getInt("price"));
			 array.add(vo);
			 
		 }
		 
	} catch (Exception e) {
		System.out.println("list" +e.toString());
	}
	 
	 return array;
 }
	
	
	   public void inesrt(BookVO vo) {
		      try {
		         String sql="select * from books where isbn=?";
		         PreparedStatement ps=Database.CON.prepareStatement(sql);
		         ps.setString(1, vo.getIsbn());
		         ResultSet rs=ps.executeQuery();
		         if(!rs.next()) {
		        	 System.out.println(vo.toString());
		            sql =" insert into books(title,contents,image,publisher,authors,price,isbn) values(?,?,?,?,?,?,?)";
		            ps=Database.CON.prepareStatement(sql);
		            ps.setString(1, vo.getTitle());
		            ps.setString(2, vo.getContents());
		            ps.setString(3, vo.getImage());
		            ps.setString(4, vo.getPublisher());
		            ps.setString(5, vo.getAuthors());
		            ps.setInt(6, vo.getPrice());
		            ps.setString(7, vo.getIsbn());
		            ps.execute();
		         }
		      }catch(Exception e) {
		         System.out.println("도서등록:" + e.toString());
		      }
		   }
}
