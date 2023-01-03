package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CouDAO {
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df=new DecimalFormat("#,###원");
	
	
	
	//교수정보수정 
			public void update(CouVO vo) {
				try {
					String sql="update courses set lname=?, room=?,hours=?,instructor=?,capacity=? where lcode=?";
					PreparedStatement ps=Data.CON.prepareStatement(sql);
					ps.setString(6, vo.getLcode());
					ps.setString(1, vo.getLname());
					ps.setString(2, vo.getRoom());
					ps.setInt(3, vo.getHours());
					ps.setString(4, vo.getInstructor());
					ps.setInt(5, vo.getCapacity());
					ps.execute();
					
				} catch (Exception e) {
					System.out.println("강좌등록: "+e.toString());
				}
			}
	
	//강좌등록 
		public void insert(CouVO vo) {
			try {
				String sql="insert into courses(lcode,lname,room,hours,instructor,capacity) values(?,?,?,?,?,?)";
				PreparedStatement ps=Data.CON.prepareStatement(sql);
				ps.setString(1, vo.getLcode());
				ps.setString(2, vo.getLname());
				ps.setString(3, vo.getRoom());
				ps.setInt(4, vo.getHours());
				ps.setString(5, vo.getInstructor());
				ps.setInt(6, vo.getCapacity());
				ps.execute();
				
			} catch (Exception e) {
				System.out.println("강좌등록: "+e.toString());
			}
		}
	
	//새강좌코드생성ㅡ 
	public String getCode() {
		String code="";
		try {
			String sql="select max(lcode) code from courses";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String lcode=rs.getString("code");
				lcode=lcode.substring(1);
				int icode=Integer.parseInt(lcode)+1;
				code = "N" +icode;
			}
			
		} catch (Exception e) {
			System.out.println("새로운 강좌코드: "+e.toString());
		}

		return code;
	}
	
	
	public CouVO read(String lcode) {
		CouVO vo=new CouVO();
		try {
			String sql="select * from cou where lcode=?";
			PreparedStatement ps=Data.CON.prepareCall(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHours(rs.getInt("hours"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setRoom(rs.getString("room"));
				
			}
			
		} catch (Exception e) {
			System.out.println("couread"+e.toString());
		}
		
		return vo;
		
	}
	
	 //강좌목록
	   public JSONObject list(SqlVO vo) {
	      JSONObject object=new JSONObject();
	      try {
	         String sql="call list('cou',?,?,?,?,?,?)";
	         CallableStatement cs=Data.CON.prepareCall(sql);
	         cs.setString(1, vo.getKey());
	         cs.setString(2, vo.getWord());
	         cs.setString(3, vo.getOrder());
	         cs.setString(4, vo.getDesc());
	         cs.setInt(5, vo.getPage());
	         cs.setInt(6, vo.getPer());
	         cs.execute();
	         
	         ResultSet rs=cs.getResultSet();
	         JSONArray jArray=new JSONArray();
	         while(rs.next()) {
	            JSONObject obj=new JSONObject();
	            obj.put("lcode", rs.getString("lcode"));
	            obj.put("lname", rs.getString("lname"));
	            obj.put("pname", rs.getString("pname"));
	            obj.put("hours", rs.getString("hours"));
	            obj.put("instructor", rs.getString("instructor"));
	            obj.put("capacity", rs.getString("capacity"));
	            obj.put("persons", rs.getString("persons"));
	            obj.put("dept", rs.getString("dept"));
	            obj.put("room", rs.getString("room"));

	            jArray.add(obj);
	         }
	         object.put("array", jArray);
	         
	         cs.getMoreResults();
	         rs=cs.getResultSet();
	         int total=0;
	         if(rs.next()) total=rs.getInt("total");
	         object.put("total", total);
	         
	         int last=total%vo.getPer()==0 ? total/vo.getPer():
	            total/vo.getPer()+1;
	         object.put("last", last);
	      }catch(Exception e) {
	         System.out.println("강좌목록:" + e.toString());
	      }
	      return object;
	   }
	

}
