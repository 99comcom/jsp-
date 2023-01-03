package controller;

import java.io.*;
import java.net.URL;

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


@WebServlet(value={"/movie/search.json","/movie/search","/movie/list","/movie/register","/download","/movie/insert", "/movie/delete"})
public class MovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MovieDAO dao=new MovieDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/movie/delete":
			int id=Integer.parseInt(request.getParameter("id"));
			String image=request.getParameter("image");
			dao.delete(id); //테이블 데이터삭제
			//이미지삭제
			try {
				File file=new File("c:/image/movie/" + image);
				file.delete();
			}catch(Exception e) {
				System.out.println("이미지삭제:" + e.toString());
			}
			break;
		case "/movie/insert":
			request.setAttribute("pageName", "/movie/insert.jsp");
			dis.forward(request, response);
			break;
		case "/download":
			image=request.getParameter("image");
			System.out.println("파일이름:" + download(image));
			break;
		case "/movie/search.json":
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
		case "/movie/list":
			page=request.getParameter("page")==null ? 1:
				Integer.parseInt(request.getParameter("page"));
			
			int count=dao.count();
			int last=(count%5)==0 ? (count/5):(count/5)+1;
			
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
		MovieVO vo=new MovieVO();
		
		switch(request.getServletPath()) {
		case "/movie/insert":
			MultipartRequest 
			multi=new MultipartRequest(
					request, 
					"c:/image/movie", 
					1024*1024*10, 
					"UTF-8", new DefaultFileRenamePolicy());
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
			vo.setLink(request.getParameter("link"));
			vo.setPubDate(request.getParameter("pubDate"));
			System.out.println(vo.toString());
			
			dao.insert(vo);
			break;
		}
	}

	//이미지 다운로드
	public String download(String image) {
		String file="";
		try {
			InputStream input=null;
			OutputStream output=null;
			
			file=image.substring(image.lastIndexOf("/")+1);
			output=new FileOutputStream("c:/image/movie/" + file);
			
			URL url=new URL(image);
			input=url.openStream();
			
			int data=0;
			while((data=input.read()) != -1) {
				output.write(data);
			}
			
			input.close();
			output.close();
		}catch(Exception e) {
			System.out.println("이미지 다운로드:" + e.toString());
		}
		return file;
	}
}







