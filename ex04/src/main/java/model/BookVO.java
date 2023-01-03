package model;

public class BookVO {
	
	private int id;
	private String title;
	private String contents;
	private String isbn;
	private String wdate;
	private String image;
	private String publisher;
	private String authors;
	private int price;
	
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getAuthors() {
		return authors;
	}
	public void setAuthors(String authors) {
		this.authors = authors;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "BookVO [id=" + id + ", title=" + title + ", contents=" + contents + ", isbn=" + isbn + ", wdate="
				+ wdate + ", image=" + image + ", publisher=" + publisher + ", authors=" + authors + ", price=" + price
				+ "]";
	}
	
	
	
	
	
	
	
	

}
