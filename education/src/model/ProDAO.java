package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ProDAO {
    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
    DecimalFormat df=new DecimalFormat("#,###원");
    
    //교수정보
    public ProVO read(String pcode) {
    	ProVO vo=new ProVO();
    	try {
    		String sql="select * from professors where pcode=?";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
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
    	}catch(Exception e) {
    		System.out.println("새교수코드:" + e.toString());
    	}
    	return vo;
    }
    
    //교수등록
    public void insert(ProVO vo) {
    	try {
    		String sql="insert into professors(pcode,pname,dept,title,salary,hiredate) values(?,?,?,?,?,?)";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ps.setString(1, vo.getPcode());
    		ps.setString(2, vo.getPname());
    		ps.setString(3, vo.getDept());
    		ps.setString(4, vo.getTitle());
    		ps.setInt(5, vo.getSalary());
    		ps.setString(6, vo.getHiredate());
    		ps.execute();
    	}catch(Exception e) {
    		System.out.println("교수등록:" + e.toString());
    	}
    }
    
    //새교수코드
    public String getCode() {
    	String code="";
    	try {
    		String sql="select max(pcode)+1 code from professors";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ResultSet rs=ps.executeQuery();
    		if(rs.next()) code=rs.getString("code");
    	}catch(Exception e) {
    		System.out.println("새교수코드:" + e.toString());
    	}
    	return code;
    }
    
	//교수목록
	public JSONObject list(SqlVO vo) {
		JSONObject object=new JSONObject();
		try {
			String sql="call list('professors',?,?,?,?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
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
				obj.put("salary", df.format(rs.getInt("salary")));
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
}
