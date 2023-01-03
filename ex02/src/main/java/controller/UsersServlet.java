package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.startup.SetAllPropertiesRule;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.UserDAO;
import model.UserVO;


@WebServlet(value = {"/users/read","/users/insert","/users","/idcheck","/users/delete","/users/update","/users/list.json","/users"})
public class UsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	UserDAO dao= new UserDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/users/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			
			ArrayList<UserVO>array=dao.list(page);
			JSONArray JArray=new JSONArray();
			for(UserVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("id",vo.getId());
				obj.put("name",vo.getName());
				obj.put("password",vo.getPassword());
				obj.put("del",vo.getDel());
				JArray.add(obj);
			}
			
			JSONObject jObject=new JSONObject();
			jObject.put("array", JArray);
			jObject.put("count",dao.count());
			
			out.println(jObject);
			break;
			
		case "/users/read":
			request.setAttribute("vo",dao.read(request.getParameter("id")));
			request.setAttribute("pageName","/users/read.jsp");
			dis.forward(request, response);
		case "/users": //사용자목록
			request.setAttribute("pageName", "/users/list.jsp");
			dis.forward(request, response);
			break;
		case"/users/insert"://사용자 등록 
			request.setAttribute("pageName", "/users/insert.jsp");
			dis.forward(request, response);
			break;
		case"/idcheck"://사용자 등록 
			String id=request.getParameter("id");
			UserVO vo=dao.read(id);
			
			JSONObject obj = new JSONObject();
			obj.put("id", vo.getId());
			out.println(obj.toJSONString());
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		UserVO vo=new UserVO();
		vo.setId(request.getParameter("id"));
		vo.setPassword(request.getParameter("password"));
		vo.setName(request.getParameter("name"));
		switch(request.getServletPath()){
			case"/users/update":
				System.out.println(vo.toString());
				dao.update(vo);
				response.sendRedirect("/users");
				break;
			case "/users/insert":
				System.out.println(vo.toString());
				dao.insert(vo);
				response.sendRedirect("/users");
				break;
			case"/users/delete":
				String id=request.getParameter("id");
				String sel=request.getParameter("sel");
				String del="";
				if(sel.equals("복구")) del="0";
				else del="1";
				dao.delete(id,del);
				break;
		}
	}

}
