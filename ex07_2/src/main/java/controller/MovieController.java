package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value = {"/movie/insert","/movie/list","/movie/search","/movie/search.json","/movie/delete","/movie/register","/download"})
public class MovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
		
		case"/movie/serach":
			request.setAttribute("pageName", "movie/search.jsp");
			break;
		}
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
