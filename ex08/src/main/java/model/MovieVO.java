package model;

import java.util.Date;

public class MovieVO {
	
	private int id;
	private String title;
	private String image;
	private String actor;
	private String director; 
	private String link;
	private String pubDate;
	private Date wdate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	@Override
	public String toString() {
		return "MovieVO [id=" + id + ", title=" + title + ", image=" + image + ", actor=" + actor + ", director="
				+ director + ", link=" + link + ", pubDate=" + pubDate + ", wdate=" + wdate + "]";
	}
	
	
	
	
	
	

}
