package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProVO;
import model.SqlVO;
import model.StuDAO;
import model.StuVO;


@WebServlet(value = {"/stu/update","/stu/read","/stu/insert","/stu/list","/stu/list.json"})
public class StuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	StuDAO sdao=new StuDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()){
		
		case"/stu/read":
			String scode=request.getParameter("scode");
			request.setAttribute("vo", sdao.read(scode));
			request.setAttribute("pageName","/stu/read.jsp");
			dis.forward(request, response);
			break;
		case"/stu/insert":
			request.setAttribute("birthday", "2003-01-01");
			request.setAttribute("code", sdao.getCode());
			request.setAttribute("pageName", "/stu/insert.jsp");
			dis.forward(request, response);
			break;
		
		case"/stu/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPer(Integer.parseInt(request.getParameter("per")));
			out.print(sdao.list(svo));
			System.out.println(sdao.list(svo));
			break;
			
		case"/stu/list":
			request.setAttribute("pageName","/stu/list.jsp");
			dis.forward(request, response);
			System.out.println("list......");
			break;
		
		
		}
		
	}
	

	
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		StuVO vo=new StuVO();
		vo.setScode(request.getParameter("scode"));
		vo.setSname(request.getParameter("sname"));
		vo.setDept(request.getParameter("dept"));
		vo.setYear(request.getParameter("year"));
		vo.setBirthday(request.getParameter("birthday"));
		vo.setAdvisor(request.getParameter("advisor"));
		
		switch(request.getServletPath()){
		case"/stu/insert":
			System.out.println(vo.toString());
			sdao.insert(vo);
			response.sendRedirect("/stu/list");
		break;
		case"/stu/update":
			sdao.update(vo);
			System.out.println("update...."+vo.toString());
			response.sendRedirect("/stu/list");
			break;

		}

	}

}
