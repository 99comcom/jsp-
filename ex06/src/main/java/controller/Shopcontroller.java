package controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.ant.jmx.JMXAccessorQueryTask;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.NaverAPI;
import model.ShopDAO;
import model.ShopVO;


@WebServlet(value = {"/download","/shop/search","/shop/list","/shop/insert","/shop/search.json","/shop/register"})
public class Shopcontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ShopDAO dao=new ShopDAO();
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		switch(request.getServletPath()) {
		
	
		
		case "/shop/insert":
			request.setAttribute("newId",dao.newId());
			System.out.println("......"+dao.newId());
			request.setAttribute("pageName", "/shop/insert.jsp");
			dis.forward(request, response);
			break;
		
		case"/download":
			String image=request.getParameter("url");
			download(image);
			break;
		case "/shop/list":	
			int page=request.getParameter("page")==null? 1:Integer.parseInt(request.getParameter("page"));
			int count=dao.count();
			int last=count%5==0 ? (count/5) : (count/5)+1;
			
			request.setAttribute("last", last);
			request.setAttribute("count", count);
			request.setAttribute("page", page);
			request.setAttribute("array",dao.list(page));
			request.setAttribute("pageName", "/shop/list.jsp");
			dis.forward(request, response);
			break;
		case "/shop/search":
			request.setAttribute("pageName", "/shop/search.jsp");
			dis.forward(request, response);
			break;
		case "/shop/search.json":
			String query=request.getParameter("query");
			page=Integer.parseInt(request.getParameter("page"));
			out.println(NaverAPI.search(query,page));
		break;

		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ShopVO vo =new ShopVO();

		
		
		switch(request.getServletPath()) {  
		case "/shop/register":
			MultipartRequest multi=new MultipartRequest(request, "/Users/woodindin/Desktop/image/",1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
			vo.setId(multi.getParameter("id"));
			vo.setTitle(multi.getParameter("title"));
			vo.setPrice(Integer.parseInt(multi.getParameter("price")));
			vo.setBrand(multi.getParameter("brand"));
			vo.setImage("/"+multi.getFilesystemName("image"));

			System.out.println(vo.toString());
			dao.insert(vo);
			response.sendRedirect("/shop/list");
			break;
		case "/shop/insert":
			vo.setId(request.getParameter("id"));
			vo.setTitle(request.getParameter("title"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setBrand(request.getParameter("brand"));
			vo.setImage(download(request.getParameter("url")));
			System.out.println("insert"+vo.toString());
			dao.insert(vo);
		break;
		}
		
	}
	
	
	
	
	public String download(String image) {
		String file="";
		
		InputStream input=null;
		OutputStream output=null;
		try {
			URL url=new URL(image);
			input=url.openStream();
			file=image.substring(image.lastIndexOf("/"));
			output=new FileOutputStream("/Users/woodindin/Desktop/image/"+file);
			
			while(true) {
				int data=input.read();
				if(data== -1) break;
				output.write(data);
			}
			
		}catch (Exception e) {
			System.out.println("다운로드 " + e.toString());
		}
		return file;
	}

}
