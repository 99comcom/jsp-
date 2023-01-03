package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.PreVO;
import model.ProDAO;
import model.SqlVO;


@WebServlet(value = {"/pro/info","/pro/list","/pro/list.json","/pro/insert","/pro/read","/pro/update"})
public class ProController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProDAO pdao=new ProDAO();


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()){
		case"/pro/info":
			request.setAttribute("vo",pdao.read(request.getParameter("prod_id")));
			request.setAttribute("pageName","/pro/info.jsp");
			dis.forward(request, response);
			break;
		case"/pro/read":
			request.setAttribute("vo",pdao.read(request.getParameter("prod_id")));
			request.setAttribute("pageName","/pro/read.jsp");
			dis.forward(request, response);
			System.out.println(pdao.read("prod_id"));
			break;
		
		case"/pro/insert":
			request.setAttribute("code",pdao.getCode());
			request.setAttribute("pageName","/pro/insert.jsp");
			dis.forward(request, response);
			break;
		
		case"/pro/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPer(Integer.parseInt(request.getParameter("per")));
			System.out.println(svo);
			out.print(pdao.list(svo));
			break;
		
		case"/pro/list":
			request.setAttribute("pageName","/pro/list.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//파일업로드
		MultipartRequest mul=new MultipartRequest(request, "/Users/woodindin/image/shop",1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
		//데이터저장
		PreVO vo= new PreVO();
		vo.setProd_id(mul.getParameter("prod_id"));
		vo.setProd_name(mul.getParameter("prod_name"));
		vo.setCompany(mul.getParameter("company"));
		vo.setMall_id(mul.getParameter("mall_id"));
		vo.setDetail(mul.getParameter("detail"));
		vo.setPrice1(Integer.parseInt(mul.getParameter("price1")));
		vo.setPrice2(Integer.parseInt(mul.getParameter("price2")));
		vo.setImage(mul.getFilesystemName("image"));
		
		
		
		
	switch(request.getServletPath()){
	
		case"/pro/update":
			vo.setProd_del(mul.getParameter("prod_del"));
			if(vo.getImage()==null) {
				vo.setImage(mul.getParameter("oldImage"));
			}
			System.out.println(vo.toString());
			pdao.update(vo);
			response.sendRedirect("/pro/list");
		
		break;
		
		case"/pro/insert":
			
			pdao.insert(vo);
			response.sendRedirect("/pro/list");
			break;
			
		}
	}

}
