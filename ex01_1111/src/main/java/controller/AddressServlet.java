package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.AddressDAO;
import model.AddressVO;

@WebServlet(value={"/","/list.json","/list", "/read", "/insert", "/update","/delete"})
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    AddressDAO dao=new AddressDAO();   
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
		case "/":
			RequestDispatcher dis=request.getRequestDispatcher("home.jsp");
			request.setAttribute("pageName", "about.jsp");
			dis.forward(request, response);
			break;
		case "/list.json":
			out.println(dao.list());
			break;
		case "/list":
			System.out.println("list............");
			dis=request.getRequestDispatcher("home.jsp");
			request.setAttribute("pageName", "list.jsp");
			dis.forward(request, response);
			break;
		case "/read":
			System.out.println("read............");
			int id=Integer.parseInt(request.getParameter("id"));
			AddressVO vo=dao.read(id);
			request.setAttribute("vo", vo);
			dis=request.getRequestDispatcher("home.jsp");
			request.setAttribute("pageName", "read.jsp");
			dis.forward(request, response);
			break;
		case "/insert":
			System.out.println("insert............");
			dis=request.getRequestDispatcher("home.jsp");
			request.setAttribute("pageName", "insert.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AddressVO vo=new AddressVO();
		vo.setName(request.getParameter("name"));
		vo.setAddress(request.getParameter("address"));
		vo.setTel(request.getParameter("tel"));
		
		switch(request.getServletPath()) {
		case "/insert":
			System.out.println("post insert............");
			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/list");
			break;
		case "/update":
			int id=Integer.parseInt(request.getParameter("id"));
			vo.setId(id);
			System.out.println(vo.toString());
			dao.update(vo);
			response.sendRedirect("/list");
			break;
		case "/delete":
			id=Integer.parseInt(request.getParameter("id"));
			dao.delete(id);
			break;
		}
	}

}
