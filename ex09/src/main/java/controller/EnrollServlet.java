package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import model.EnrollDAO;


@WebServlet(value = {"/enroll/update","/enroll/slist.json","/enroll/check","/enroll/clist.json","/enroll/alist.json","/enroll/insert","/enroll/delete"})
public class EnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	EnrollDAO edao=new EnrollDAO();
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()){
		
			case"/enroll/slist.json":
				String lcode=request.getParameter("lcode");
				System.out.println("slist........."+edao.slist(lcode));
				out.println(edao.slist(lcode));
				break;
			
			case"/enroll/check":
				lcode=request.getParameter("lcode");
				String scode=request.getParameter("scode");
				JSONObject obj=new JSONObject();
				obj.put("count",edao.check(lcode, scode));
				out.print(obj);
				
				break;
		
			
			case"/enroll/clist.json":
				scode=request.getParameter("scode");
				out.println(edao.clist(scode));
				break;
				
			case"/enroll/alist.json":
				out.println(edao.alist());
				break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String lcode=request.getParameter("lcode");
		String scode=request.getParameter("scode");
		switch(request.getServletPath()){
		case"/enroll/delete":
			edao.delete(lcode, scode);
			break;
		
		case"/enroll/insert":
			edao.insert(lcode,scode);
			break;
			
		case"/enroll/update":
			int grade=Integer.parseInt(request.getParameter("grade"));
			System.out.println("update......."+lcode+scode+grade);
			edao.update(lcode,scode,grade);
			
		}
	}

}
