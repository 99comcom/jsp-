package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LocalDAO;
import model.LocalVO;


@WebServlet(value={"/local/search","/local/list","/local/list.json","/local/insert"})
public class LocalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	LocalDAO dao=new LocalDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/local/search":
			request.setAttribute("pageName", "/local/search.jsp");
			dis.forward(request, response);
			break;
		case "/local/list":
			int page=request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			
			int count=dao.count();
			int last=(count%7)==0 ? (count/7): (count/7)+1;
			
			System.out.println("last.." + last);
			request.setAttribute("page", page);
			request.setAttribute("last", last);
			
			request.setAttribute("array", dao.list(page));
			request.setAttribute("count", dao.count());
			request.setAttribute("pageName", "/local/list.jsp");
			dis.forward(request, response);
			break;	
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		LocalVO vo=new LocalVO();
		
		vo.setId(request.getParameter("id"));
		vo.setName(request.getParameter("name"));
		vo.setPhone(request.getParameter("phone"));
		vo.setKeyword(request.getParameter("keyword"));
		vo.setX(Double.parseDouble(request.getParameter("x")));
		vo.setY(Double.parseDouble(request.getParameter("y")));
		vo.setAddress(request.getParameter("address"));
		
		switch(request.getServletPath()) {
		case "/local/insert":
			//System.out.println(vo.toString());
			dao.insert(vo);
			break;
		}
	}

}
