package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.jsoup.*;
import org.jsoup.nodes.*;
import org.jsoup.select.Elements;


@WebServlet(value={"/crawl/best","/crawl/best.json","/crawl/news","/crawl/cgv.json", "/crawl/cgv", "/crawl/naver/top.json", "/crawl/naver/news.json"})
public class CrawlController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/crawl/best":
			request.setAttribute("pageName", "/crawl/best.jsp");
			dis.forward(request, response);
			break;
		case "/crawl/best.json":
			try {
				Document doc=Jsoup.connect("https://comic.naver.com/index").get();
				Elements es=doc.select(".genreRecom .genreRecomList li");
				JSONArray array=new JSONArray();

				for(Element e:es) {
					String title=e.select(".genreRecomImg img").attr("title");
					String image=e.select(".genreRecomImg img").attr("src");
					String summary=e.select(".genreRecomInfo .summary").text();
					String star=e.select(".genreRecomInfo .rating_type strong").text();
					//System.out.println(title + "\n" + image + "\n" + summary + "\n" + star);
					if(title != "") {
						JSONObject obj=new JSONObject();
						obj.put("title", title);
						obj.put("image", image);
						obj.put("summary", summary);
						obj.put("star", star);
						array.add(obj);
					}
				}
				//out.println(array);
				JSONObject object=new JSONObject();
				JSONArray group1=new JSONArray();
				JSONArray group2=new JSONArray();
				JSONArray group3=new JSONArray();
				
				for(int i=0; i<array.size(); i++) {
					if(i/3==0) {
						group1.add(array.get(i));
					}else if(i/3==1) {
						group2.add(array.get(i));
					}else if(i/3==2) {
						group3.add(array.get(i));
					}
				}
				object.put("group1", group1);
				object.put("group2", group2);
				object.put("group3", group3);
				out.println(object);
				
			}catch(Exception e) {
				System.out.println("주식 Top" + e.toString());
			}
			break;
		case "/crawl/news":
			request.setAttribute("pageName", "/crawl/news.jsp");
			dis.forward(request, response);
			break;
		case "/crawl/naver/news.json":
			try {
				Document doc=Jsoup.connect("https://finance.naver.com/news/mainnews.naver").get();
				Elements es=doc.select(".newsList li");
				JSONArray array=new JSONArray();
				for(Element e:es) {
					String title=e.select("a").text();
					String content=e.select(".articleSummary").text();
					String link=e.select("a").attr("href");
					String image=e.select("img").attr("src");
					
					JSONObject obj=new JSONObject();
					obj.put("title", title);
					obj.put("link", link);
					obj.put("content", content);
					obj.put("image", image);
					array.add(obj);
				}
				out.println(array);
			}catch(Exception e) {
				System.out.println("주식 Top" + e.toString());
			}
			break;
		case "/crawl/naver/top.json":
			try {
				Document doc=Jsoup.connect("https://finance.naver.com/").get();
				Elements es=doc.select("#_topItems1 tr");
				JSONArray array=new JSONArray();
				for(Element e:es) {
					String title=e.select("a").text();
					String price=e.select("td").get(0).text();
					String rate=e.select("td").get(1).text();
					JSONObject obj=new JSONObject();
					obj.put("title", title);
					obj.put("price", price);
					obj.put("rate", rate);
					array.add(obj);
				}
				out.println(array);
			}catch(Exception e) {
				System.out.println("주식 Top" + e.toString());
			}
			break;
		case "/crawl/cgv":
			request.setAttribute("pageName", "/crawl/cgv.jsp");
			dis.forward(request, response);
			break;
		case "/crawl/cgv.json":
			try {
				Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/?lt=3&ft=1").get();
				Elements es=doc.select(".sect-movie-chart ol li");
				JSONArray array=new JSONArray();
				
				for(Element e:es) {
					var title=e.select(".title").text();
					var image=e.select("img").attr("src");
					var date=e.select(".txt-info strong").text();
					var percent=e.select(".percent span").text();
					var link=e.select("a").attr("href");
					if(title != "") {
						JSONObject obj = new JSONObject();
						obj.put("title", title);
						obj.put("image", image);
						obj.put("date", date);
						obj.put("percent", percent);
						obj.put("link", "http://cgv.co.kr/" + link);
						array.add(obj);
					}
				}
				out.println(array);
			}catch(Exception e) {
				System.out.println("무비챠트:" + e.toString());
			}
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
