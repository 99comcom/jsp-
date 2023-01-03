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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


@WebServlet(value = {"/crawl/comic","/crawl/naver/comic.json","/crawl/news","/crawl/cgv","/crawl/cgv.json","/crawl/naver/top.json","/crawl/naver/news.json"})
public class CrawlController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();
		
		switch(request.getServletPath()) {
		case "/crawl/comic":
			request.setAttribute("pageName","/crawl/comic.jsp");
			dis.forward(request, response);
			break;
			
		case "/crawl/naver/comic.json":
			try {
				Document doc=Jsoup.connect("https://comic.naver.com/index").get();
				Elements es=doc.select(".genreRecom .genreRecomList li");
				JSONArray array=new JSONArray();

				for(Element e:es) {

					String title=e.select(".genreRecomInfo .title a").text();
					String content=e.select(".summary").text();
					String user=e.select(".user").text();
					String link=e.select("a").attr("href");
					String image=e.select(".genreRecomImg img").attr("src");
					String star=e.select(".rating_type strong").text();
					
					if(image!="") {
					JSONObject obj=new JSONObject();
					obj.put("star",star);
					obj.put("title",title);
					obj.put("link",link);
					obj.put("content",content);
					obj.put("image",image);
					obj.put("user",user);
					array.add(obj);
					System.out.println("........." +title+"\n"+content+"..."+image+"\n"+link + "\n"+star);
					}
				}
				out.println(array);
				
			} catch (Exception e) {
				System.out.println("웹툰"+e.toString());
			}
			
			
			
			break;
			
			
		
		case "/crawl/news":
			request.setAttribute("pageName","/crawl/news.jsp");
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
					obj.put("title",title);
					obj.put("link",link);
					obj.put("content",content);
					obj.put("image",image);
					array.add(obj);
					
				}
				out.println(array);
				
			} catch (Exception e) {
				System.out.println("네이버뉴스"+e.toString());
			}
			
			
			
			break;
		
		case"/crawl/naver/top.json":
			try {
				Document doc=Jsoup.connect("https://finance.naver.com/").get();
				Elements es=doc.select("#_topItems1 tr");
				JSONArray array=new JSONArray();

				for(Element e:es) {
					String title=e.select("a").text();
					String price=e.select("td").get(0).text();
					String rate=e.select("td").get(1).text();
//					System.out.println("주식..........." +title+"\n"+price+"..."+rate);
					JSONObject obj=new JSONObject();
					obj.put("title",title);
					obj.put("price",price);
					obj.put("rate",rate);
					array.add(obj);
					
				}
				out.println(array);
				
			} catch (Exception e) {
				System.out.println("네이버주식"+e.toString());
			}
			
			break;
		
		case" /crawl/cgv":
			request.setAttribute("pageName","/crawl/cgv.jsp");
			dis.forward(request, response);
			break;
			
		case "/crawl/cgv.json": //cgv무바차트크롤링
				try {
					Document doc=Jsoup.connect("http://www.cgv.co.kr/movies/?lt=1&ft=0").get();
					Elements es=doc.select(".sect-movie-chart ol li");
					JSONArray array=new JSONArray();
					for(Element e:es) {
						
						var title=e.select(".title").text();
						var image=e.select("img").attr("src");
						var date=e.select(".txt-info strong").text();
						var percent=e.select(".percent span").text();
						var link=e.select("a").attr("href");
							if(title!="") {
								JSONObject obj=new JSONObject();
								obj.put("title",title);
								obj.put("image",image);
								obj.put("date",date);
								obj.put("percent",percent);
								obj.put("link","http://cgv.co.kr/"+link);
								array.add(obj);
//								System.out.println("..................."+title+"......."+image+"\n"+date+"......"+percent);
							}
						
					}
					out.println(array);
				
						
				} catch (Exception e) {
				System.out.println(("크롤링json"+e.toString()));
				}
			
			break;
		case "/crawl/cgv":
			request.setAttribute("pageName","/crawl/cgv.jsp");
			dis.forward(request, response);
			
			break;
			
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}





















