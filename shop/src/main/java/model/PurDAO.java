package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class PurDAO {
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df=new DecimalFormat("#,###");
	
	
	//주문상품등록
	public void insert(OrderVO vo) {
		try {
			String sql="insert into orders(order_id,pord_id,price,qnt) values(?,?,?,?)";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ps.setString(1, vo.getOrder_id());
			ps.setString(2, vo.getProd_id());
			ps.setInt(3,vo.getPrice());
			ps.setInt(4,vo.getQnt());
			ps.execute();

			
		} catch (Exception e) {
			System.out.println("주문상품등록"+e.toString());
		}
		
	}
	
	//주문등록
	public JSONObject insert(PurVO vo) {
		JSONObject obj= new JSONObject();
		try {
			String sql="select concat('R', max(substring(order_id,2,3)+1)) code from purchase";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setOrder_id(rs.getString("code"));
				obj.put("code",vo.getOrder_id());
				sql="insert into purchase(order_id,name,address,email,tel,payType) values(?,?,?,?,?,?)";
				ps=Data.CON.prepareStatement(sql);
				ps.setString(1,vo.getOrder_id());
				ps.setString(2,vo.getName());
				ps.setString(3,vo.getAddress());
				ps.setString(4,vo.getEmail());
				ps.setString(5,vo.getTel());
				ps.setString(6,vo.getPayType());
				ps.execute();
				System.out.println(ps);
				
			}
		} catch (Exception e) {
			System.out.println("주문등록:111" + e.toString());
		}
		
		
		
		return obj;
	}
	
	
	//상태변경
	public void updateStatus(String id, String status) {
		try {
			String sql="update purchase set status=? where order_id=?";
			PreparedStatement ps=Data.CON.prepareStatement(sql);
			ps.setString(1, status);
			ps.setString(2, id);
			ps.execute();
		} catch (Exception e) {
			System.out.println(""+e.toString());
		}
	}
	
	
	
	//주문자정보 
	public JSONObject read(String id) {
		JSONObject obj=new JSONObject();

	      try {
	         String sql="call order_info(?)";
	         CallableStatement cs=Data.CON.prepareCall(sql);
	         cs.setString(1, id);
	         cs.execute();
	         
	         ResultSet rs= cs.executeQuery();
	         if(rs.next()) {
	        	 JSONObject ob=new JSONObject();
	            ob.put("order_id", rs.getString("order_id"));
	            ob.put("name", rs.getString("name"));
	            ob.put("address", rs.getString("address"));
	            ob.put("email", rs.getString("email"));
	            ob.put("tel", rs.getString("tel"));
	            String pdate=sdf.format(rs.getTimestamp("pdate"));
	            ob.put("pdate", pdate);
	             ob.put("payType", rs.getString("payType"));
	             ob.put("status", rs.getString("status"));
	             obj.put("pur",ob);

	         }
	         
	         cs.getMoreResults();
	         rs=cs.getResultSet();
	         JSONArray array=new JSONArray();
	         int total=0;
	         while(rs.next()) {
	        	 JSONObject ob=new JSONObject();
	        	 ob.put("order_id", rs.getString("order_id"));
		         ob.put("prod_name", rs.getString("prod_name"));
		         ob.put("prod_id", rs.getString("prod_id"));
		         ob.put("company", rs.getString("company"));
		         ob.put("price", df.format(rs.getInt("price")));
		         ob.put("qnt", df.format(rs.getInt("quantity")));
		         ob.put("sum", df.format(rs.getInt("total")));
		         ob.put("image", rs.getString("image"));
		         total += rs.getInt("total");
		         array.add(ob);
		         
	         }
	         obj.put("array", array);
	         obj.put("total",df.format(total));
	         
	         
	         
	         
	      }catch(Exception e) {
	         System.out.println("주문자정보:" + e.toString());
	      }
	      return obj;
	   }
	
	
	
	//주문목록
		 public JSONObject list(SqlVO vo) {
		      JSONObject object=new JSONObject();
		      try {
		         String sql="call list('purchase',?,?,?,?,?,?)";
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
		            obj.put("order_id", rs.getString("order_id"));
		            obj.put("name", rs.getString("name"));
		            obj.put("address", rs.getString("address"));
		            obj.put("email", rs.getString("email"));
		            obj.put("tel", rs.getString("tel"));
		            String pdate=sdf.format(rs.getTimestamp("pdate"));
		            obj.put("pdate", pdate);
		            obj.put("email", rs.getString("payType"));
		            obj.put("status", rs.getString("status"));

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
		         System.out.println("업체목록:" + e.toString());
		      }
		      return object;
		   }
	
	

}
