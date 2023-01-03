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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.BookDAO;
import model.BookVO;


@WebServlet(value={"/book/list.json","/book/search","/book/insert","/book/list"})
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BookDAO dao= new BookDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("home.jsp");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		case "/book/search":
			System.out.println("search.....");
			request.setAttribute("pageName", "/book/search.jsp");
			dis.forward(request, response);
			break;
		case"/book/list":
			System.out.println("list.....");
			request.setAttribute("pageName", "/book/list.jsp");
			dis.forward(request, response);
			break;
			

			
		case"/book/list.json":
			System.out.println("json.....");
			int page=Integer.parseInt(request.getParameter("page"));
			ArrayList<BookVO> array=dao.list(page);
			JSONArray JArray=new JSONArray();
			
			for(BookVO vo:array) {
				JSONObject obj=new JSONObject();
				obj.put("id",vo.getId());
				obj.put("title",vo.getTitle());
				obj.put("image",vo.getImage());
				obj.put("publisher",vo.getPublisher());
				obj.put("authors",vo.getAuthors());
				obj.put("price",vo.getPrice());
				JArray.add(obj);

				}
			JSONObject jObj=new JSONObject();
			jObj.put("array", JArray);
			jObj.put("count",dao.count());; 
			out.print(jObj);
			
			break;
			
		}	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      request.setCharacterEncoding("UTF-8");
	      
	      BookVO vo=new BookVO();
	      vo.setTitle(request.getParameter("title"));
	      vo.setContents(request.getParameter("contents"));
	      vo.setImage(request.getParameter("image"));
	      vo.setPublisher(request.getParameter("publisher"));
	      vo.setAuthors(request.getParameter("authors"));
	      vo.setIsbn(request.getParameter("isbn"));
	      vo.setPrice(Integer.parseInt(request.getParameter("price")));
	      
	      switch(request.getServletPath()) {
	      case "/book/insert":
	    	  dao.inesrt(vo);
//	         System.out.println(vo.toString());
	         break;
	      }
	}

}
