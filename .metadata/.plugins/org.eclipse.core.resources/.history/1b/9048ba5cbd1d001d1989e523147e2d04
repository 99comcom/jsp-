package model;

import java.sql.*;
import java.text.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public class ProDAO {
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df=new DecimalFormat("#,###원");
	
	//교수정보수정 
		public void update(ProVO vo) {
			try {
				String sql="update professors set pname=?,dept=?,title=?,salary=?,hiredate=? where pcode=?";
				PreparedStatement ps=Data.CON.prepareStatement(sql);
				ps.setString(6, vo.getPcode());
				ps.setString(1, vo.getPname());
				ps.setString(2, vo.getDept());
				ps.setString(3, vo.getTitle());
				ps.setInt(4, vo.getSalary());
				ps.setString(5, vo.getHiredate());
				ps.execute();
				
			} catch (Exception e) {
				System.out.println("교수정보수정: "+e.toString());
			}
		}
	
	//특정교수가 담당하는 학생 몰록
		public JSONArray slist(String pcode){
			JSONArray array=new JSONArray();
			try{
				String sql="select *from students where advisor=? ";
				PreparedStatement ps=Data.CON.prepareStatement(sql);
					ps.setString(1, pcode);
					ResultSet rs=ps.executeQuery();
					while(rs.next()){
						JSONObject obj=new JSONObject();
						obj.put("scode",rs.getString("scode"));
						obj.put("sname",rs.getString("sname"));
						obj.put("dept",rs.getString("dept"));
						obj.put("year",rs.getString("year"));
						String birthday=sdf.format(rs.getDate("birthday"));
						obj.put("birthday",birthday);
						array.add(obj);
					}
			} catch (Exception e) {
					System.out.println("특정교수가 담당하는 학생 몰록: "+e.toString());
				}
			return array;
		}
		
	
	
	
	//특정교수가 강의하는 강의 몰록
	public JSONArray clist(String pcode){
		JSONArray array=new JSONArray();
		try{
			String sql="select *from courses where instructor=?";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
				ps.setString(1, pcode);
				ResultSet rs=ps.executeQuery();
				while(rs.next()){
					JSONObject obj=new JSONObject();
					obj.put("lcode",rs.getString("lcode"));
					obj.put("lname",rs.getString("lname"));
					obj.put("room",rs.getString("room"));
					obj.put("hours",rs.getString("hours"));
					obj.put("capacity",rs.getInt("capacity"));
					obj.put("persons",rs.getInt("persons"));
					array.add(obj);
				}



		} catch (Exception e) {
				System.out.println("특정교수가 강의하는 강의몰록: "+e.toString());
			}
		return array;
	}
	
	
	//교수정보 
	public ProVO read(String pcode) {
		ProVO vo=new ProVO();
		try {
			String sql="select *from professors where pcode=?";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ps.setString(1, pcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				vo.setHiredate(sdf.format(rs.getDate("hiredate")));
			}
			
		} catch (Exception e) {
			System.out.println("교수정보: "+e.toString());
		}
		return vo;
	}
	
	//교수등록 
	public void insert(ProVO vo) {
		try {
			String sql="insert into professors(pcode,pname,dept,title,salary,hiredate) values(?,?,?,?,?,?)";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ps.setString(1, vo.getPcode());
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getTitle());
			ps.setInt(5, vo.getSalary());
			ps.setString(6, vo.getHiredate());
			ps.execute();
			
		} catch (Exception e) {
			System.out.println("교수등록: "+e.toString());
		}
	}
	
	
	
	//교수등록코드ㅡ 
	public String getCode() {
		String code="";
		try {
			String sql="select max(pcode) code from professors";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				int newCode=Integer.parseInt(rs.getString("code"))+1;
				code = String.valueOf(newCode);
				
			}
			
		} catch (Exception e) {
			System.out.println("새교수코드: "+e.toString());
		}

		return code;
	}
	
	
	   //교수목록
	   public JSONObject list(SqlVO vo) {
	      JSONObject object=new JSONObject();
	      try {
	         String sql="call list('professors',?,?,?,?,?,?)";
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
	            obj.put("pcode", rs.getString("pcode"));
	            obj.put("pname", rs.getString("pname"));
	            obj.put("dept", rs.getString("dept"));
	            obj.put("title", rs.getString("title"));
	            obj.put("hiredate", sdf.format(rs.getDate("hiredate")));
	            obj.put("salary", df.format( rs.getInt("salary")));
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
	         System.out.println("교수목록:" + e.toString());
	      }
	      return object;
	   }
	
	

	//교수목록
//	   public JSONObject list(SqlVO vo) {
//	      JSONObject object=new JSONObject();
//	      try {
//	         String sql="call list('professors',?,?,?,?,?,?)";
//	         CallableStatement cs=Data.CON.prepareCall(sql);
//	         cs.setString(1, vo.getKey());
//	         cs.setString(2, vo.getWord());
//	         cs.setString(3, vo.getOrder());
//	         cs.setString(4, vo.getDesc());
//	         cs.setInt(5, vo.getPage());
//	         cs.setInt(6, vo.getPer());
//	         cs.execute();
//	         
//	         ResultSet rs=cs.getResultSet();
//	         JSONArray jArray=new JSONArray();
//	         while(rs.next()) {
//	            JSONObject obj=new JSONObject();
//	            obj.put("pcode", rs.getString("pcode"));
//	            obj.put("pname", rs.getString("pname"));
//	            obj.put("dept", rs.getString("dept"));
//	            obj.put("title", rs.getString("title"));
//	            obj.put("hiredate", sdf.format(rs.getString("hiredate")));
//	            obj.put("salary", df.format( rs.getInt("salary")));
//	            jArray.add(obj);
//	         }
//	         object.put("array", jArray);
//	         
//	         cs.getMoreResults();
//	         rs=cs.getResultSet();
//	         int total=0;
//	         if(rs.next()) total=rs.getInt("total");
//	         object.put("total", total);
//	         
//	         int last=total%vo.getPer()==0 ? total/vo.getPer(): total/vo.getPer()+1;
//	         object.put("last", last);
//
//	      }catch(Exception e) {
//	         System.out.println("교수목록:" + e.toString());
//	      }
//	      return object;
//	   }

}
