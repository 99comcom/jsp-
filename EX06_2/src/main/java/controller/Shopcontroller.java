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

		switch(request.getServerPort()) {
		case "/shop//search.
		}
		}

	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		
	}
	
	
}
	
