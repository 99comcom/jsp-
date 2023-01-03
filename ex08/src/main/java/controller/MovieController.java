package controller;

import java.io.*;
import java.net.URL;
import java.util.PrimitiveIterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.MovieDAO;
import model.MovieVO;
import model.NaverAPI;


@WebServlet(value = {"/movie/delete","/movie/search.json","/movie/search","/movie/list","/movie/register","/download","/movie/insert"})
public class MovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       MovieDAO dao=new MovieDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/movie/delete":
			int id=Integer.parseInt(request.getParameter("id"));
			String image=request.getParameter("image");
			dao.delete(id);//테이블에서 데이터삭제
			//이미지삭제	
			try {
				File file=new File("/Users/woodindin/image/"+image);
				file.delete();
			} catch (Exception e) {
				System.out.println("이미지삭제 "+ e.toString());
			}
			
			
			
			
			
			
			break;

		case"/movie/insert":
			request.setAttribute("pageName", "/movie/insert.jsp");
			dis.forward(request, response);
			break;
		case "/download":
			image=request.getParameter("image");
			download(image);
			System.out.println("파일다운로드....." +download(image));
			break;
		case"/movie/search.json":
			int page=request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			
			String query=request.getParameter("query")==null ? "배트맨":
				request.getParameter("query");
			String result=NaverAPI.search(query, page);
			out.println(result);
				
			break;
		case "/movie/search":
			request.setAttribute("pageName", "/movie/search.jsp");
			dis.forward(request, response);
			break;
			
		case"/movie/list":
			page=request.getParameter("page")==null ? 1: Integer.parseInt(request.getParameter("page"));
			
			int count=dao.count();
			int last=count%5 == 0 ? (count/5):(count/5)+1;
			request.setAttribute("page", page);
			request.setAttribute("count", count);
			request.setAttribute("last", last);
			request.setAttribute("array", dao.list(page));
			request.setAttribute("pageName", "/movie/list.jsp");
			dis.forward(request, response);
			break;

			
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		MovieVO vo =new MovieVO();

		switch(request.getServletPath()) {
		
		case"/movie/insert":
		MultipartRequest multi=new MultipartRequest(request, "/Users/woodindin/image/",1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
		vo.setTitle(multi.getParameter("title"));
		vo.setImage(multi.getFilesystemName("image"));
		vo.setActor(multi.getParameter("actor"));
		vo.setDirector(multi.getParameter("director"));
		vo.setPubDate(multi.getParameter("pubDate"));
		dao.insert(vo);
		response.sendRedirect("/movie/list");
		
		break;
		
		case "/movie/register":
			vo.setTitle(request.getParameter("title"));
			String image=download(request.getParameter("image"));
			vo.setImage(image);
			vo.setActor(request.getParameter("actor"));
			vo.setDirector(request.getParameter("director")); 
			vo.setPubDate(request.getParameter("pubDate"));
			vo.setLink(request.getParameter("actor"));
			dao.insert(vo);
			response.sendRedirect("/movie/list");
			break;
		}
		
	}

	//이미지다운로드
	public String download(String image) {
String file="";
		
		InputStream input=null;
		OutputStream output=null;
		try {
			URL url=new URL(image);
			input=url.openStream();
			file=image.substring(image.lastIndexOf("/")+1);
			output=new FileOutputStream("/Users/woodindin/image/"+file);
			
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















