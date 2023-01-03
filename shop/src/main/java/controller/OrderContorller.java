package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.OrderVO;
import model.PurDAO;
import model.PurVO;
import model.SqlVO;

@WebServlet(value = {"/order/insrt","/order/list","/order/list.json","/order/read.json","/update/status","/pur/insert"})
public class OrderContorller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       PurDAO dao=new PurDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		
		switch(request.getServletPath()) {
		
		case"/update/status":
			String id=request.getParameter("id");
			String status=request.getParameter("status");
			dao.updateStatus(id, status);
			break;
		
		case"/order/read.json":
			out.print(dao.read(request.getParameter("id")));
			break;
		
		case"/order/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPer(Integer.parseInt(request.getParameter("per")));
			System.out.println(svo);
			out.print(dao.list(svo));
			break;
		
		case"/order/list":
			request.setAttribute("pageName","/order/list.jsp");
			dis.forward(request, response);
			
		case"/pur/insert":
			PurVO vo=new PurVO();
			vo.setName(request.getParameter("name"));
			vo.setAddress(request.getParameter("address"));
			vo.setTel(request.getParameter("tel"));
			vo.setEmail(request.getParameter("email"));
			vo.setPayType(request.getParameter("payType"));
			System.out.println(vo.toString());
			out.print(dao.insert(vo));
			
			
			break;
			case"/order/insert":
				OrderVO ovo=new OrderVO();
				ovo.setOrder_id(request.getParameter("oid"));
				ovo.setProd_id(request.getParameter("pid"));
				ovo.setPrice(Integer.parseInt(request.getParameter("price")));
				ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
				dao.insert(ovo);
				System.out.println("22222222222222....."+ovo.toString());
				break;
			
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		
		switch(request.getServletPath()) {
		
		
		
		}
		
	}

}
