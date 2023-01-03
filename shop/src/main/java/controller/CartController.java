package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CartVO;
import model.PreVO;
import model.ProDAO;


@WebServlet(value = {"/cart/list","/cart/insert","/cart/delete","/cart/update"})
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ProDAO pdao=new ProDAO();
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session=request.getSession();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		
		switch(request.getServletPath()) {
		
		case"/cart/delete":
			String id=request.getParameter("id");
			ArrayList<CartVO> carts= (ArrayList<CartVO>)session.getAttribute("carts");
			for(CartVO vo:carts) {
				if(id.equals(vo.getProd_id())) {
					carts.remove(vo);
					break;
				}
			}
			session.setAttribute("carts",carts);
			break;
			
		case"/cart/update":
			id=request.getParameter("id");
			int qnt= Integer.parseInt(request.getParameter("qnt"));
			carts= (ArrayList<CartVO>)session.getAttribute("carts");
			for(CartVO vo:carts) {
				if(id.equals(vo.getProd_id())) {
					vo.setQnt(qnt);
					vo.setSum(vo.getQnt() * vo.getPrice2());
					break;
				}
			}
			session.setAttribute("carts", carts);
			break;
		
		case"/cart/list":
			request.setAttribute("pageName", "/cart/list.jsp");
			dis.forward(request, response);
			break;
		case"/cart/insert":
			id=request.getParameter("id");
			PreVO pvo=pdao.read(id);
			System.out.println(pvo.toString());
			CartVO cvo=new CartVO();
			cvo.setProd_id(id);
			cvo.setProd_name(pvo.getProd_name());
			cvo.setPrice2(pvo.getPrice2());
			cvo.setQnt(1);
			cvo.setSum(cvo.getPrice2()*cvo.getQnt());
			
			
			carts=session.getAttribute("carts")==null ? new ArrayList<CartVO>() : (ArrayList<CartVO>)session.getAttribute("carts");
			
			boolean find=false;
			for(CartVO vo: carts) {
				if(id.equals(vo.getProd_id())) {
					vo.setQnt(vo.getQnt()+1);
					vo.setSum(vo.getQnt()*vo.getPrice2());
					find=true;
					break;
				}
			}
			if(find==false)	carts.add(cvo);
			session.setAttribute("carts", carts);

		
		}

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		
		
		
	}
}